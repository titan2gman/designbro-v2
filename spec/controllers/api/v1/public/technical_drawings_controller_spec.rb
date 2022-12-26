# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::TechnicalDrawingsController do
  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, UploadedFile::TechnicalDrawing
      post :create, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
