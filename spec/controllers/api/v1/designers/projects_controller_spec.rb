# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Designers::ProjectsController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#search' do
    it 'cancan does not allow :search' do
      @ability.cannot :search, Project
      get :search, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#index' do
    it 'cancan does not allow :index' do
      @ability.cannot :index, Project
      get :index, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
