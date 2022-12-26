# frozen_string_literal: true

module Api
  module V1
    module Public
      class DesignersController < Api::V1::ApplicationController
        http_basic_authenticate_with name: ENV.fetch('API_USERNAME'), password: ENV.fetch('API_PASSWORD')

        load_and_authorize_resource

        def index
          @paginated_designers = DesignersQuery::Search.new(@designers).search(params).page(params[:page]).per(params[:per_page])

          meta = pagination_data(@paginated_designers)

          render json: ::Public::Designer::DesignerBlueprint.render(@paginated_designers, root: :data, meta: meta, view: :list)
        end

        def show
          @designer = Designer.where(visible: true, one_to_one_available: true).includes(
            reviews: {
              project: [
                :active_nda, :company,
                product: :product_category,
                brand_dna: :brand
              ]
            },
            portfolio_works: [:product_category, :uploaded_file],
            winner_spots: [
              { design: :uploaded_file },
              { project: [
                :active_nda, :company,
                designs: :uploaded_file,
                product: :product_category,
                brand_dna: :brand
              ] }
            ]
          ).find(params[:id])

          render json: ::Public::Designer::DesignerBlueprint.render(@designer, view: :single)
        end
      end
    end
  end
end
