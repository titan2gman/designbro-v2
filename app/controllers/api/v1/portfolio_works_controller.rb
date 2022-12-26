# frozen_string_literal: true

module Api
  module V1
    class PortfolioWorksController < Api::V1::ApplicationController
      serialization_scope :view_context

      before_action :authenticate_designer!

      load_and_authorize_resource only: [:index, :create]

      def index
        respond_with @portfolio_works.order(:index)
      end

      def create
        @form = PortfolioForm.new(portfolio_params)
        @form.save

        respond_with @form.designer
      end

      def skip
        designer.update(portfolio_uploaded: true)
        respond_with designer
      end

      private

      def portfolio_params
        params.require(:portfolio).permit(
          portfolio_works: [:uploaded_file_id, :product_category_id, :description]
        ).to_h.merge(id: designer.id)
      end
    end
  end
end
