# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::ProjectInspirationsController do
  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, ProjectInspiration
      post :create, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#destroy' do
    let(:project_inspiration) { create(:project_inspiration) }

    it 'cancan does not allow :destroy' do
      @ability.cannot :destroy, ProjectInspiration
      delete :destroy, params: { format: :json, id: project_inspiration.inspiration_image.id }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
