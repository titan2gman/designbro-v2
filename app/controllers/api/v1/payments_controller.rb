# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < Api::V1::ApplicationController
      serialization_scope :view_context

      before_action :authenticate_api_v1_user!

      load_and_authorize_resource

      def index
        @payments = @payments.order(created_at: :desc).page(params[:page]).per(5)
        respond_with @payments, meta: pagination_data(@payments)
      end
    end
  end
end
