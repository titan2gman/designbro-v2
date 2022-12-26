# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Designs::VersionsController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#index' do
    let(:design) { create(:design) }
    let(:params) do
      {
        format: :json,
        project_id: design.project.id,
        design_id: design.id
      }
    end

    it 'cancan does not allow :read' do
      @ability.cannot :read, Design
      get :index, params: params

      expect(response).to have_http_status(:forbidden)
    end
  end
end
