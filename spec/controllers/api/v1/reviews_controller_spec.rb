# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ReviewsController do
  let(:client) { create(:client) }

  before do
    request.headers.merge!(client.user.create_new_auth_token)
  end

  context '#index' do
    it 'cancan does not allow :read' do
      @ability.cannot :read, Review
      get :index, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#create' do
    let(:design) { create(:design) }
    let(:review) { attributes_for(:review).merge(design_id: design.id) }

    it 'cancan does not allow :create' do
      @ability.cannot :create, Review
      post :create, params: { format: :json, review: review }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
