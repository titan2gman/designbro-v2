# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DiscountsController do
  let(:discount) { create(:discount) }
  let(:client) { create(:client) }

  let(:params) do
    {
      format: :json,
      id: discount.code
    }
  end

  before do
    request.headers.merge!(client.user.create_new_auth_token)
  end

  context '#show' do
    it 'cancan does not allow :show' do
      @ability.cannot :show, Discount
      get :show, params: params

      expect(response).to have_http_status(:forbidden)
    end
  end
end
