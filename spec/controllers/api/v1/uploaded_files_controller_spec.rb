# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UploadedFilesController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, UploadedFile::DesignerPortfolioWork
      post :create, params: { format: :json, type: 'designer_portfolio_work' }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
