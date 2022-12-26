# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SpotsController do
  let(:designer) { create(:designer) }
  let(:token)    { designer.user.create_new_auth_token }

  before { request.headers.merge!(token) }

  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, Spot
      post :create, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
