# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payouts API' do
  describe 'GET /api/v1/payouts' do
    it 'responds with 200 (OK) and returns payouts' do
      designer = create(:designer)
      headers = designer.user.create_new_auth_token
      create(:earning, designer: designer)
      create(:payout, designer: designer)

      get api_v1_payouts_path, headers: headers

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('payouts/index')
    end
  end

  describe 'POST /api/v1/payouts' do
    it 'responds with 201 and returns payout' do
      designer = create(:designer)
      headers = designer.user.create_new_auth_token

      params = { payout: attributes_for(:payout) }

      post api_v1_payouts_path, headers: headers, params: params

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('payouts/create')
    end
  end
end
