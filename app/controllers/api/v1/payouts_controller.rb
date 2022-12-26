# frozen_string_literal: true

module Api
  module V1
    class PayoutsController < Api::V1::ApplicationController
      serialization_scope :view_context
      before_action :authenticate_api_v1_user!
      load_and_authorize_resource

      def index
        @payouts = @payouts.order('id DESC').page(params[:page]).per(5)
        respond_with(@payouts, meta: pagination_data(@payouts))
      end

      def create
        @form = PayoutForm.new(object: @payout)
        @form.save
        respond_with @form.payout
      end

      private

      def payout_params
        params.require(:payout).permit(
          :country,
          :payout_method,
          :paypal_email,
          :iban,
          :swift,
          :first_name,
          :last_name,
          :address1,
          :address2,
          :city,
          :state,
          :phone
        ).to_h
      end
    end
  end
end
