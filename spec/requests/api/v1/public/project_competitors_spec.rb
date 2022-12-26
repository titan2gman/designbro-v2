# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::ProjectCompetitorsController, type: :controller do
  describe 'POST /project_competitor' do
    describe 'for guest' do
      scenario 'responds with 201 (CREATED) and renders created project competitor' do
        project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
        cookies.encrypted[:project_id] = project.id

        post :create, params: { file: file_to_upload, format: :json }

        expect(response).to have_http_status(:created)
        expect(response).to match_response_schema('project_competitors/create')
      end
    end

    describe 'for client' do
      describe 'responds with 201 (CREATED) and renders created project' do
        scenario 'responds with 201 (CREATED) and renders created project competitor' do
          project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS)
          cookies.encrypted[:project_id] = project.id

          headers = project.client.user.create_new_auth_token
          request.headers.merge! headers

          post :create, params: { file: file_to_upload, format: :json }

          expect(response).to have_http_status(:created)
          expect(response).to match_response_schema('project_competitors/create')
        end
      end
    end
  end

  describe 'DELETE /project_competitor' do
    describe 'for guest' do
      scenario 'responds with 200 (OK) and renders destroyed project competitor' do
        project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS, client: nil)
        project_competitor = create(:project_competitor, project: project)
        cookies.encrypted[:project_id] = project.id

        delete :destroy, params: { id: project_competitor.competitor_logo.id, format: :json }

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('project_competitors/destroy')
      end
    end

    describe 'for client' do
      scenario 'responds with 200 (OK) and renders destroyed project competitor' do
        project = create(:project, state: Project::STATE_WAITING_FOR_FINISH_DETAILS)
        project_competitor = create(:project_competitor, project: project)
        cookies.encrypted[:project_id] = project.id

        headers = project.client.user.create_new_auth_token
        request.headers.merge! headers

        delete :destroy, params: { id: project_competitor.competitor_logo.id, format: :json }

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('project_competitors/destroy')
      end
    end
  end
end
