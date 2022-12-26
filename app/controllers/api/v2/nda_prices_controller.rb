# frozen_string_literal: true

module Api
  module V2
    class NdaPricesController < Api::V2::ApplicationController
      def index
        @nda_prices = policy_scope(NdaPrice)

        render json: NdaPriceBlueprint.render(@nda_prices)
      end
    end
  end
end
