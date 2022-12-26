# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clients API' do
  describe 'PATCH /api/v1/clients/:id' do
    it 'responds with 200 (OK) and returns updated client info' do
      client = create(:client)
      headers = client.user.create_new_auth_token
      params = { client: attributes_for(:client) }

      patch api_v1_client_path(client), headers: headers, params: params

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('client/update')
    end
  end
end
