# frozen_string_literal: true

module Api
  module V1
    class PortfolioImagesController < Api::V1::ApplicationController
      before_action :load_portfolio_images
      authorize_resource

      def index
        raise ActiveRecord::RecordNotFound unless @portfolio_images

        respond_with @portfolio_images
      end

      private

      def load_portfolio_images
        @portfolio_images = if params[:portfolio_list]
                              PortfolioList.find_by(portfolio_list_params)&.portfolio_images
                            else
                              PortfolioImage.all
                            end
      end

      def portfolio_list_params
        params.require(:portfolio_list).permit(:list_type)
      end
    end
  end
end
