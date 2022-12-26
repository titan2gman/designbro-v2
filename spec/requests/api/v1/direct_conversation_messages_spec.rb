# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Direct Conversation Messages API' do
  describe 'GET /api/v1/projects/:project_id/designs/:design_id/messages' do
    context 'designer' do
      it 'responds with 200 (OK) and returns list of messages' do
        designer = create(:designer)
        headers = designer.user.create_new_auth_token
        project = create(:project)
        design = create(:design, project: project, designer: designer)
        project.designers << designer

        get api_v1_project_design_messages_path(project, design), headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('direct_conversation_messages/index')
      end

      it 'responds with 403 (Forbidden) for design of another designer' do
        designer = create(:designer)
        headers = designer.user.create_new_auth_token
        project = create(:project)
        design = create(:design, project: project)

        get api_v1_project_design_messages_path(project, design), headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'client' do
      it 'responds with 200 (OK) and returns list of messages' do
        client = create(:client)
        headers = client.user.create_new_auth_token
        project = create(:project, client: client)
        design = create(:design, project: project)

        get api_v1_project_design_messages_path(project, design), headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('direct_conversation_messages/index')
      end

      it 'responds with 403 (Forbidden) for project of another client' do
        client = create(:client)
        headers = client.user.create_new_auth_token
        project = create(:project)
        design = create(:design, project: project)

        get api_v1_project_design_messages_path(project, design), headers: headers

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST /api/v1/projects/:project_id/designs/:design_id/messages' do
    context 'designer' do
      it 'responds with 201 (Created) and returns just created message' do
        designer = create(:designer)
        headers = designer.user.create_new_auth_token
        project = create(:project)
        design = create(:design, project: project, designer: designer)
        project.designers << designer
        attrs = attributes_for(:direct_conversation_message)

        post api_v1_project_design_messages_path(project, design),
             headers: headers,
             params: { direct_conversation_message: attrs }

        expect(response).to have_http_status(:created)
        expect(response).to match_response_schema('direct_conversation_messages/create')
      end
    end
  end
end
