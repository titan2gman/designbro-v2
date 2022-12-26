# frozen_string_literal: true

module Api
  module V2
    class ApplicationController < ActionController::Base
      include DeviseTokenAuth::Concerns::SetUserByToken
      include Pundit

      rescue_from Pundit::NotAuthorizedError, with: -> { head :forbidden }
      rescue_from ActiveRecord::RecordNotFound, with: -> { head :not_found }
      rescue_from ActionController::BadRequest, with: -> { head :bad_request }

      before_action :set_last_seen_at

      after_action :set_signed_uid_cookie

      respond_to :json
      responders :json

      private

      def designer
        @designer ||= current_user.designer if current_user.present?
      end

      def client
        @client ||= current_user.client if current_user.present?
      end

      def company
        @company ||= current_client.company if current_client.present?
      end

      def set_last_seen_at
        user_online_tracker.call(current_user) unless current_user.blank?
      end

      def authenticate_client!
        head :unauthorized unless client
      end

      def authenticate_designer!
        head :unauthorized unless designer
      end

      def user_online_tracker
        @user_online_tracker ||= UserOnlineTracker.new
      end

      def pagination_data(entities)
        {
          current_page: entities.current_page,

          next_page: entities.next_page,
          prev_page: entities.prev_page,

          total_pages: entities.total_pages,
          total_count: entities.total_count
        }
      end

      def raise_bad_request_exception
        raise ActionController::BadRequest
      end

      def set_signed_uid_cookie
        cookies.permanent.encrypted[:signed_uid] = current_user.uid if current_user
      end

      alias current_user current_api_v1_user
      alias current_designer designer
      alias current_client client
      alias current_company company
    end
  end
end
