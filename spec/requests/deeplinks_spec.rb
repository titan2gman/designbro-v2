# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Deeplinks' do
  describe 'GET /continue_brief' do
    describe 'invalid token' do
      it 'redirects_to url expired page' do
        create(:client)
        json_web_token = 'Some_invalid_token'
        expected_url = "#{ENV.fetch('ROOT_URL')}/errors/link-expired"

        get "/continue_brief?token=#{json_web_token}"

        expect(response.cookies['signed_uid']).to be_blank
        expect(response.cookies[DeviseTokenAuth.headers_names[:'access-token']]).to be_blank
        expect(response.cookies[DeviseTokenAuth.headers_names[:'token-type']]).to be_blank
        expect(response.cookies[DeviseTokenAuth.headers_names[:client]]).to be_blank
        expect(response.cookies[DeviseTokenAuth.headers_names[:uid]]).to be_blank
        expect(response).to redirect_to(expected_url)
      end
    end

    it 'redirects to brief with auth headers' do
      client = create(:client)
      json_web_token = JsonWebToken.encode(client_id: client.id)
      expected_url = "#{ENV.fetch('ROOT_URL')}/c"

      get "/continue_brief?token=#{json_web_token}"

      expect(response.cookies[DeviseTokenAuth.headers_names[:'access-token']]).to be_present
      expect(response.cookies[DeviseTokenAuth.headers_names[:'token-type']]).to be_present
      expect(response.cookies[DeviseTokenAuth.headers_names[:client]]).to be_present
      expect(response.cookies[DeviseTokenAuth.headers_names[:uid]]).to be_present
      expect(response.cookies['signed_uid']).to be_present
      expect(response).to redirect_to(expected_url)
    end
  end
end
