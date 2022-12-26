# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::Base
      include DeviseTokenAuth::Concerns::SetUserByToken

      rescue_from CanCan::AccessDenied, with: -> { head :forbidden }
      rescue_from ActiveRecord::RecordNotFound, with: -> { head :not_found }
      rescue_from ActionController::BadRequest, with: -> { head :bad_request }

      before_action :set_last_seen_at
      before_action :extract_project_id_from_cookies

      after_action :set_signed_uid_cookie

      respond_to :json
      responders :json

      private

      def current_ability
        @current_ability ||= Ability.new(current_user, @project_id_from_cookies)
      end

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

      def extract_project_id_from_cookies
        @project_id_from_cookies = cookies.encrypted[:project_id]
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
