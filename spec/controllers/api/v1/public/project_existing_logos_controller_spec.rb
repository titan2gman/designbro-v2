# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::ProjectExistingLogosController do
  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, ProjectExistingLogo
      post :create, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#destroy' do
    let(:project_existing_logo) { create(:project_existing_logo) }

    it 'cancan does not allow :destroy' do
      @ability.cannot :destroy, ProjectExistingLogo
      delete :destroy, params: { format: :json, id: project_existing_logo.existing_logo.id }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
