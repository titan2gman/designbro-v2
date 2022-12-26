# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectsController do
  let(:client) { create(:client) }

  before do
    request.headers.merge!(client.user.create_new_auth_token)
  end

  context '#search' do
    it 'cancan does not allow :search' do
      @ability.cannot :search, Project
      get :search, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#show' do
    let(:project) { create(:project) }

    it 'cancan does not allow :show' do
      @ability.cannot :show, Project
      get :show, params: { format: :json, id: project.id }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#update' do
    let(:project) { create(:project) }

    it 'cancan does not allow :update' do
      @ability.cannot :update, Project
      patch :update, params: { format: :json, id: project.id }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#destroy' do
    let(:project) { create(:project) }

    it 'cancan does not allow :destroy' do
      @ability.cannot :destroy, Project
      delete :destroy, params: { format: :json, id: project.id }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
