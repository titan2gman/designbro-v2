# frozen_string_literal: true

module Api
  module V2
    class BrandsController < Api::V2::ApplicationController
      def index
        @brands = policy_scope(Brand)

        render json: BrandBlueprint.render(@brands)
      end
    end
  end
end
