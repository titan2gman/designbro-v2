# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FaqGroupsController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#index' do
    it 'cancan does not allow :read' do
      @ability.cannot :read, FaqGroup
      get :index, params: { format: :json }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
