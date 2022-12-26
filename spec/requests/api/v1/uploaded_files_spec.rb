# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Uploads API' do
  describe 'POST /api/v1/uploaded_files' do
    context 'with designer_portfolio_work' do
      it 'responds with 201 (Created) and respond with created file' do
        user = create(:designer).user
        headers = user.create_new_auth_token
        params = attributes_for(:designer_portfolio_work).merge(type: 'designer_portfolio_work')

        post api_v1_uploaded_files_path, headers: headers, params: params

        expect(response).to have_http_status(:created)
        expect(response).to match_response_schema('designer_portfolio_work/created')
      end
    end
  end
end
