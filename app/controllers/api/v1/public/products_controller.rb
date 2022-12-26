# frozen_string_literal: true

module Api
  module V1
    module Public
      class ProductsController < Api::V1::ApplicationController
        load_and_authorize_resource

        def index
          respond_with @products.includes(
            :product_category, :additional_design_prices, :additional_screen_prices,
            :project_brief_components,
            project_builder_steps: :project_builder_questions
          ), include: '**'
        end
      end
    end
  end
end
