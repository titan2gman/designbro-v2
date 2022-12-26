# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'NdaPrices API' do
  describe 'GET /nda_prices' do
    describe 'client' do
      it 'responds with 200 (OK) and renders nda prices' do
        client = create(:client)
        headers = client.user.create_new_auth_token

        get '/api/v1/nda_prices', params: { format: :json }, headers: headers

        expect(response).to have_http_status(:ok)
        expect(response).to match_response_schema('nda_prices/index')
      end
    end
  end
end
