# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Public::ProjectWizardController do
  before do
    cookies.encrypted[:project_id] = create(:project, client: nil).id
  end

  let(:project) { create(:logo_project, state: :waiting_for_details, client: nil) }

  let(:project_params) do
    {
      project_type: :logo,
      bad_examples: [],
      skip_examples: [],
      good_examples: []
    }
  end

  let(:params) do
    {
      format: :json,
      step: :examples,
      project: project_params,
      upgrade_project_state: true
    }
  end

  context '#update' do
    it 'cancan does not allow :update' do
      @ability.cannot :update, Project
      patch :update, params: params

      expect(response).to have_http_status(:forbidden)
    end
  end

  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, Project
      post :create, params: params

      expect(response).to have_http_status(:forbidden)
    end
  end
end
