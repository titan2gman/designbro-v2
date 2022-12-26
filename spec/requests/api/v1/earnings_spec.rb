# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'earnings API' do
  describe 'GET /api/v1/earnings' do
    it 'responds with 200 (OK) and returns earnings' do
      designer = create(:designer)
      create(:earning, designer: designer)
      headers = designer.user.create_new_auth_token

      get api_v1_earnings_path, headers: headers

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('earnings/index')
    end
  end
end
