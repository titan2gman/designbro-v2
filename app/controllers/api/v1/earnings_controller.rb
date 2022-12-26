# frozen_string_literal: true

module Api
  module V1
    class EarningsController < Api::V1::ApplicationController
      serialization_scope :view_context
      before_action :authenticate_api_v1_user!
      load_and_authorize_resource

      def index
        @earnings = @earnings.page(params[:page]).per(5)
        respond_with @earnings, meta: pagination_data(@earnings)
      end
    end
  end
end
