# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Designers API' do
  describe 'PATCH /api/v1/designers/:id' do
    it 'responds with 200 (OK) and returns updated designer info' do
      designer = create(:designer)
      headers = designer.user.create_new_auth_token
      params = { designer: attributes_for(:designer) }

      patch api_v1_designer_path(designer), headers: headers, params: params

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('designer/update')
    end
  end

  describe 'PATCH /api/v1/designers/:id/experience' do
    it 'responds with 200 (OK) and returns updated designer info' do
      designer = create(:designer)
      headers = designer.user.create_new_auth_token
      params = { designer: attributes_for(:designer) }

      patch experience_api_v1_designer_path(designer), headers: headers, params: params

      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema('designer/update')
    end
  end
end
