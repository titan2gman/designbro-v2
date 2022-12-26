# frozen_string_literal: true

module Api
  module V1
    module Public
      class AdditionalScreenPricesController < Api::V1::ApplicationController
        load_and_authorize_resource

        def index
          respond_with @additional_screen_prices
        end
      end
    end
  end
end
