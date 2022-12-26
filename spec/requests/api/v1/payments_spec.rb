# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payments API' do
  describe 'GET /api/v1/payments' do
    it 'responds with 200 (OK) and returns payments' do
      client = create(:payment).client

      headers = client.user.create_new_auth_token
      get api_v1_payments_path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('payments/index')
    end
  end
end
