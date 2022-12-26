# frozen_string_literal: true

module Api
  module V1
    class DiscountsController < Api::V1::ApplicationController
      serialization_scope :view_context

      before_action :authenticate_client!

      def show
        @discount = Discount.active.find_by(code: params[:id])
        respond_with @discount
      end
    end
  end
end
