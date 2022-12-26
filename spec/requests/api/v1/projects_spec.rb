# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects API' do
  describe 'GET /project' do
    describe 'guest' do
      let(:project) { create(:project) }

      it 'responds with 403 (Forbidden) and renders errors for guest' do
        get '/api/v1/project', params: { format: :json, id: project.id }

        expect(response).to have_http_status(:forbidden)
      end

      it 'responds with 404 (Not found) for guest without id' do
        get '/api/v1/project', params: { format: :json }

        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'designer' do
      it 'responds with 403 (Forbidden) and renders errors for designer' do
        get '/api/v1/project', headers: create(:designer).user.create_new_auth_token

        expect(response).to have_http_status(:forbidden)
      end
    end

    describe 'client' do
      it 'responds with 200 (OK) and renders project (state: :waiting_for_details)' do
        client = create(:client)
        headers = client.user.create_new_auth_token

        create(:project, state: Project::STATE_WAITING_FOR_DETAILS, client: client)

        get '/api/v1/project', params: { format: :json }, headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 200 (OK) and renders project (state: :waiting_for_checkout)' do
        client = create(:client)
        headers = client.user.create_new_auth_token

        create(:project, state: Project::STATE_WAITING_FOR_CHECKOUT, client: client)

        get '/api/v1/project', params: { format: :json }, headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 404 (NOT FOUND) if there is no project with unfinished states' do
        client = create(:client)
        create(:project, client: client, state: Project::STATE_DESIGN_STAGE)

        get '/api/v1/project', headers: client.user.create_new_auth_token

        expect(response).to have_http_status(:not_found)
        expect(response.body).to eq ''
      end
    end
  end

  describe 'GET /projects/:id' do
    context 'designer' do
      it 'responds with 200 (OK) and returns project' do
        project      = create(:project, state: Project::STATE_DESIGN_STAGE)
        designer_nda = create(:designer_nda, nda: project.nda)
        designer     = designer_nda.designer

        create(:reserved_spot, designer: designer, project: project)

        headers = designer.user.create_new_auth_token
        get api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 403 (Forbidden) without nda' do
        project = create(:project, state: Project::STATE_DESIGN_STAGE)
        designer = create(:designer)

        headers = designer.user.create_new_auth_token
        get api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'client' do
      it 'responds with 200 (OK) and returns project' do
        project = create(:project, state: Project::STATE_DESIGN_STAGE)
        client = project.client

        headers = client.user.create_new_auth_token
        get api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 403 (Forbidden) for project of another client' do
        project = create(:project, state: Project::STATE_DESIGN_STAGE)
        client = create(:client)

        headers = client.user.create_new_auth_token
        get api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'PATCH /projects/:id' do
    context 'designer' do
      it 'responds with 200 (OK) and returns project' do
        project = create(:project, state: Project::DESIGNER_CAN_UPDATE_STATES.sample)
        designer_nda = create(:designer_nda, nda: project.nda)
        designer = designer_nda.designer

        create(:reserved_spot, designer: designer, project: project)

        headers = designer.user.create_new_auth_token
        patch api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 403 (Forbidden) with not allowed project state' do
        project = create(:project, state: Project::STATE_ERROR)
        designer_nda = create(:designer_nda, nda: project.nda)
        designer = designer_nda.designer

        headers = designer.user.create_new_auth_token
        patch api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:forbidden)
      end

      it 'responds with 403 (Forbidden) with designer client block' do
        project = create(:project, state: Project::DESIGNER_CAN_UPDATE_STATES.sample)
        designer_nda = create(:designer_nda, nda: project.nda)
        designer = designer_nda.designer
        create(:designer_client_block, designer: designer, client: project.client)

        headers = designer.user.create_new_auth_token
        patch api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'client' do
      it 'responds with 200 (OK) and returns project' do
        project = create(:project, state: Project::CLIENT_CAN_UPDATE_STATES.sample)
        client = project.client
        allow_any_instance_of(ProjectForm).to receive(:save).and_return(true)

        headers = client.user.create_new_auth_token
        params = attributes_for(:project)
        patch api_v1_project_path(project), headers: headers, params: params

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('projects/show')
      end

      it 'responds with 403 (Forbidden) for project of another client' do
        project = create(:project, state: Project::CLIENT_CAN_UPDATE_STATES.sample)
        client = create(:client)

        headers = client.user.create_new_auth_token
        patch api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:forbidden)
      end

      it 'responds with 403 (Forbidden) for project with not allowed state' do
        project = create(:project, state: Project::STATE_ERROR)
        client = create(:client)

        headers = client.user.create_new_auth_token
        patch api_v1_project_path(project), headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST /projects/:id/reserve_spot' do
    it 'respond with 201' do
      project      = create(:project, state: Project::STATE_DESIGN_STAGE)
      designer_nda = create(:designer_nda, nda: project.nda)
      designer     = designer_nda.designer

      headers = designer.user.create_new_auth_token
      post "/api/v1/projects/#{project.id}/reserve_spot", headers: headers

      expect(response).to have_http_status(:created)
    end

    it 'respond with 403 (Forbidden) with error state' do
      project = create(:project, state: Project::STATE_ERROR)
      designer_nda = create(:designer_nda, nda: project.nda)
      designer = designer_nda.designer
      headers = designer.user.create_new_auth_token

      post "/api/v1/projects/#{project.id}/reserve_spot", headers: headers

      expect(response).to have_http_status(:forbidden)
    end

    it 'respond with 403 (Forbidden) without nda' do
      project = create(:project, state: Project::DESIGNER_CAN_UPDATE_STATES.sample)
      designer = create(:designer)
      headers = designer.user.create_new_auth_token

      post "/api/v1/projects/#{project.id}/reserve_spot", headers: headers

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'GET /api/v1/search' do
    context 'with client' do
      it 'returns only client projects' do
        client = create(:client)
        headers = client.user.create_new_auth_token
        projects = create_list(:project, 2, client: client)
        create_list(:project, 2)

        get search_api_v1_projects_path, headers: headers
        ids = json['data'].map { |p| p['id'].to_i }

        expect(response).to match_response_schema('projects/index')
        expect(response).to have_http_status(:ok)
        expect(ids).to match_array(projects.map(&:id))
      end
    end

    context 'with state_in' do
      it 'returns only projects which match state_in' do
        client = create(:client)
        headers = client.user.create_new_auth_token
        projects = create_list(:project, 2, client: client, state: Project::STATE_COMPLETED)
        create_list(:project, 2)

        search_params = { state_in: ['completed'] }
        get search_api_v1_projects_path, headers: headers, params: search_params
        ids = json['data'].map { |p| p['id'].to_i }

        expect(response).to have_http_status(:ok)
        expect(ids).to match_array(projects.map(&:id))
        expect(response).to match_response_schema('projects/index')
      end
    end
  end
end
