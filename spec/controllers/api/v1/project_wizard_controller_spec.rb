# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectWizardController do
  let(:client) { create(:client) }

  before do
    request.headers.merge!(client.user.create_new_auth_token)
  end

  context '#update' do
    before do
      create(:logo_project, state: :waiting_for_details, client: client)
      create(:logo_project_price)
    end

    let(:params) do
      {
        format: :json,
        step: :details,
        project: attributes_for(:project)
      }
    end

    it 'cancan does not allow :update' do
      @ability.cannot :update, Project
      patch :update, params: params

      expect(response).to have_http_status(:forbidden)
    end
  end
end
