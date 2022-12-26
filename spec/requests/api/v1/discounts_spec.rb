# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discounts API' do
  describe 'GET /api/v1/discounts/:discount_code' do
    it 'responds with 200 (OK) and renders percent discount information' do
      client = create(:client)

      discount = create(:percent_discount)

      path    = api_v1_discount_path(discount.code)
      headers = client.user.create_new_auth_token
      get path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('discounts/show')
    end

    it 'responds with 200 (OK) and renders dollar discount information' do
      client = create(:client)

      discount = create(:dollar_discount)

      path    = api_v1_discount_path(discount.code)
      headers = client.user.create_new_auth_token
      get path, headers: headers

      expect(response).to have_http_status(:ok)
      expect(response).to match_response_schema('discounts/show')
    end

    it 'responds with 404 (not found)' do
      client = create(:client)

      path    = api_v1_discount_path('CODE')
      headers = client.user.create_new_auth_token
      get path, headers: headers

      expect(response).to have_http_status(:not_found)
    end

    it 'responds with 401 (unauthorized)' do
      designer = create(:designer)

      discount = create(:discount)

      path    = api_v1_discount_path(discount.code)
      headers = designer.user.create_new_auth_token
      get path, headers: headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
