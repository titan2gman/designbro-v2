# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < Api::V1::ApplicationController
      before_action :authenticate_client!

      load_and_authorize_resource

      def index
        parameters = params.permit(:designer_id_eq).to_h
        respond_with @reviews.ransack(parameters).result
      end

      def create
        @review.save

        respond_with @review
      end

      private

      def review_params
        params.require(:review).permit(
          :design_id,
          :designer_rating,
          :designer_comment,
          :overall_rating,
          :overall_comment
        )
      end
    end
  end
end
