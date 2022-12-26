# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'designer projects API' do
  describe 'POST /api/v1/spots' do
    it 'responds with 201 and returns spot' do
      designer = create(:designer)
      project  = create(:project, state: Project::STATE_DESIGN_STAGE)
      create(:designer_nda, designer: designer, nda: project.nda)

      headers = designer.user.create_new_auth_token
      post api_v1_spots_path, headers: headers, params: { project_id: project.id }

      expect(response).to have_http_status(:created)
      expect(response).to match_response_schema('spots/create')
    end

    it 'responds with 403' do
      project  = create(:project)
      designer = create(:designer)
      create(:designer_nda, designer: designer, nda: project.nda)

      headers = designer.user.create_new_auth_token
      post api_v1_spots_path, headers: headers, params: { project_id: project.id }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
