# frozen_string_literal: true

module Api
  module V1
    class PayoutMinAmountsController < Api::V1::ApplicationController
      load_and_authorize_resource

      def index
        respond_with @payout_min_amounts
      end
    end
  end
end
