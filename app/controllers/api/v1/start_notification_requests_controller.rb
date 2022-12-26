# frozen_string_literal: true

module Api
  module V1
    class StartNotificationRequestsController < Api::V1::ApplicationController
      load_and_authorize_resource

      def create
        @start_notification_request.save
        respond_with @start_notification_request
      end

      def start_notification_request_params
        params.require(:start_notification_request).permit(:email)
      end
    end
  end
end
