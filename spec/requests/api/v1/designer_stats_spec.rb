# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Designer Stats API' do
  describe 'GET /api/v1/designer_stats/:id' do
    it 'responds with 200 (OK) and renders design information' do
      designer = create(:designer)

      headers = designer.user.create_new_auth_token
      get api_v1_designer_stats_path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('designer/stats')
    end
  end
end
