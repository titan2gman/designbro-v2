# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'PATCH api/v1/users/:id' do
    it 'responds with 200 (OK) and returns updated user info for designer' do
      user = create(:designer).user
      headers = user.create_new_auth_token

      params = { user: attributes_for(:user) }

      patch api_v1_user_path(user), headers: headers, params: params

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('user/update')
    end

    it 'responds with 200 (OK) and returns updated user info for client' do
      user = create(:client).user
      headers = user.create_new_auth_token

      params = { user: attributes_for(:user) }

      patch api_v1_user_path(user), headers: headers, params: params

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('user/update')
    end
  end
end
