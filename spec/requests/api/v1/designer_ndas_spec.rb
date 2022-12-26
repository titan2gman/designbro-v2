# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Designer NDAs API' do
  describe 'GET /api/v1/designer_ndas' do
    it 'responds with 200 (OK) and renders ndas' do
      designer_nda = create(:designer_nda)
      designer     = designer_nda.designer

      headers = designer.user.create_new_auth_token
      get api_v1_designer_ndas_path, headers: headers

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('designer_ndas/index')
    end
  end

  describe 'POST /api/v1/designer_ndas' do
    it 'responds with 200 (OK) and renders nda' do
      designer = create(:designer)
      project  = create(:project, state: Project::STATE_DESIGN_STAGE)

      params  = { nda_id: project.nda.id }
      headers = designer.user.create_new_auth_token
      post api_v1_designer_ndas_path, headers: headers, params: params

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('designer_ndas/create')
    end
  end
end
