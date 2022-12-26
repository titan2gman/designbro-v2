# frozen_string_literal: true

module Api
  module V1
    module Public
      class VatRatesController < Api::V1::ApplicationController
        load_and_authorize_resource

        def index
          respond_with @vat_rates
        end
      end
    end
  end
end
