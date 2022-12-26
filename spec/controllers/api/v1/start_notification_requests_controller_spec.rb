# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StartNotificationRequestsController do
  let(:designer) { create(:designer) }

  before do
    request.headers.merge!(designer.user.create_new_auth_token)
  end

  context '#create' do
    it 'cancan does not allow :create' do
      @ability.cannot :create, StartNotificationRequest
      post :create, params: {
        format: :json,
        start_notification_request: attributes_for(:start_notification_request)
      }

      expect(response).to have_http_status(:forbidden)
    end
  end
end
