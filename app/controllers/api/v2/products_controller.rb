# frozen_string_literal: true

module Api
  module V2
    class ProductsController < Api::V2::ApplicationController
      def index
        @products = policy_scope(Product)

        render json: ProductBlueprint.render(@products, view: :attributes)
      end
    end
  end
end
