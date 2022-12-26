# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Designs API' do
  describe 'GET /api/v1/projects/:project_id/designs/:id' do
    it 'responds with 200 (OK) and renders design information' do
      designer = create(:designer)
      project  = create(:project, state: Project::STATE_DESIGN_STAGE)
      design   = create(:design, project: project, designer: designer)

      create(:designer_nda, nda: project.nda, designer: designer)

      path    = api_v1_project_design_path(project, design)
      headers = designer.user.create_new_auth_token
      get path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('designs/show')
    end
  end

  describe 'GET /api/v1/projects/:project_id/designs/:id/versions' do
    it 'responds with 200 (OK) and renders design versions' do
      design   = create(:design)
      project  = design.project
      designer = design.designer

      path    = api_v1_project_design_versions_path(project, design)
      headers = designer.user.create_new_auth_token
      get path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('designs/versions')
    end
  end

  describe 'PATCH /api/v1/projects/:project_id/designs/:id/restore' do
    describe 'designer' do
      it 'responds with 200 (OK) and renders design information' do
        designer = create(:designer)
        project  = create(:project, state: Project::STATE_DESIGN_STAGE)
        design   = create(:design, project: project, designer: designer)

        create(:designer_nda, nda: project.nda, designer: designer)

        old_file = design.uploaded_file
        design.update(uploaded_file: create(:design_file))

        path    = restore_api_v1_project_design_path(project, design)
        headers = designer.user.create_new_auth_token
        params  = { version_id: old_file.id }

        patch path, headers: headers, params: params

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('designs/show')
      end
    end

    describe 'client' do
      it 'responds with 403 (Forbidden)' do
        client   = create(:client)
        project  = create(:project, state: Project::STATE_DESIGN_STAGE, client: client)
        design   = create(:design, project: project)

        old_file = design.uploaded_file
        design.update(uploaded_file: create(:design_file))

        path    = restore_api_v1_project_design_path(project, design)
        headers = client.user.create_new_auth_token
        params  = { version_id: old_file.id }

        patch path, headers: headers, params: params

        expect(response.body).to eq('')
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET /api/v1/projects/:project_id/designs' do
    it 'responds with 200 (OK) and renders designs list' do
      designer = create(:designer)
      project  = create(:project, state: Project::STATE_DESIGN_STAGE)

      create(:design, project: project, designer: designer)
      create(:designer_nda, designer: designer, nda: project.nda)

      headers = designer.user.create_new_auth_token
      get api_v1_project_designs_path(project), headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('designs/index')
    end
  end

  describe 'PATCH /api/v1/projects/:project/designs/:design/eliminate' do
    it 'responds with 200 (OK) and renders design with associations' do
      project  = create(:project, state: Project::STATE_DESIGN_STAGE)
      design   = create(:design, project: project)

      path    = eliminate_api_v1_project_design_path(project, design)
      headers = project.client.user.create_new_auth_token
      patch path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('designs/eliminate')
    end
  end
end
