# frozen_string_literal: true

module Api
  module V1
    class ClientsController < Api::V1::ApplicationController
      before_action :authenticate_api_v1_user!

      def update
        @form = ClientForm.new(client_params)
        @form.save

        respond_with @form.client
      end

      private

      def client_params
        params.require(:client).permit(
          :email, :first_name, :last_name, :country, :country_code, :address1,
          :address2, :city, :state_name, :zip, :phone, :vat,
          :payment_type, :payment_method_id
        ).to_h.merge(id: client.id)
      end
    end
  end
end
