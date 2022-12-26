# frozen_string_literal: true

module Api
  module V2
    class VatRatesController < Api::V2::ApplicationController
      def index
        @vat_rates = policy_scope(VatRate)

        render json: VatRateBlueprint.render(@vat_rates)
      end
    end
  end
end
