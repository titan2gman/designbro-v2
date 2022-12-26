# frozen_string_literal: true

module Api
  module V2
    class DiscountsController < Api::V2::ApplicationController
      def show
        @discount = Discount.active.find_by(code: params[:id])

        if @discount
          render json: DiscountBlueprint.render(@discount)
        else
          render json: {}
        end
      end
    end
  end
end
