# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectSourceFilesController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#index' do
    let(:project) { create(:project) }

    it 'cancan does not allow :read' do
      @ability.cannot :read, ProjectSourceFile
      get :index, params: { format: :json, project_id: project.id }

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#destroy' do
    let(:project_source_file) { create(:project_source_file) }

    it 'cancan does not allow :destroy' do
      @ability.cannot :destroy, ProjectSourceFile
      delete :destroy, params: {
        format: :json,
        project_id: project_source_file.project.id,
        id: project_source_file.id
      }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
