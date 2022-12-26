# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::ProjectAdditionalDocumentsController do
  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, ProjectAdditionalDocument
      cookies.encrypted[:project_id] = create(:project, client: nil).id
      post :create, params: { format: :json, file: file_to_upload }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#destroy' do
    let(:project_additional_document) { create(:project_additional_document) }

    it 'cancan does not allow :destroy' do
      @ability.cannot :destroy, ProjectAdditionalDocument
      delete :destroy, params: { format: :json, id: project_additional_document.additional_document.id }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
