# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DesignerStatsController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#show' do
    it 'cancan does not allow :read' do
      @ability.cannot :read, Designer
      get :show, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
