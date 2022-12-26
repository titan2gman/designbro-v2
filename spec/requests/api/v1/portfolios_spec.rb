# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Portfolios API' do
  let(:designer) { create(:designer) }
  let(:headers) { designer.user.create_new_auth_token }

  describe 'GET /api/v1/portfolios' do
    it 'responds with 200 (:OK) and returns portfolios' do
      get api_v1_portfolios_path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('portfolios/index')
    end
  end

  describe 'POST /api/v1/portfolios' do
    it 'responds with 201 (Created) and renders updated designer' do
      file = create(:designer_portfolio_work)
      works = [attributes_for(:portfolio_work).merge(id: file.id)]
      params = { portfolio: { portfolio_works: works } }

      post api_v1_portfolios_path, headers: headers, params: params

      expect(response).to have_http_status(:created)
      expect(response).to match_response_schema('designer/update')
    end
  end

  describe 'PATCH /api/v1/portfolios/skip' do
    it 'responds with 200 (Created) and renders updated designer' do
      patch skip_api_v1_portfolios_path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('designer/update')
    end
  end
end
