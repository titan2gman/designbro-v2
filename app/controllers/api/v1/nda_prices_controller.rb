# frozen_string_literal: true

module Api
  module V1
    class NdaPricesController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        respond_with @nda_prices
      end
    end
  end
end
