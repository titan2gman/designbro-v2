# frozen_string_literal: true

module Api
  module V1
    module Public
      class ReviewsController < Api::V1::ApplicationController
        http_basic_authenticate_with name: ENV.fetch('API_USERNAME'), password: ENV.fetch('API_PASSWORD')

        load_and_authorize_resource

        def index
          @reviews = @reviews.joins(design: { project: :product }).where(products: { key: params[:product] }) if params[:product]

          @paginated_reviews = @reviews.includes(
            :designer,
            client: :company,
            design: {
              project: [
                :spots_with_uploaded_design, {
                  featured_image: :uploaded_featured_image,
                  product: :product_category,
                  brand_dna: :brand
                }
              ]
            }
          ).order('created_at DESC NULLS LAST, id DESC').page(params[:page]).per(params[:per_page])

          meta = pagination_data(@paginated_reviews).merge(reviews_statistics)

          respond_with @paginated_reviews, each_serializer: PublicReviewSerializer, meta: meta
        end

        private

        def reviews_statistics
          {
            average_rating: @reviews.pluck('avg(overall_rating), avg(designer_rating)').first.map!(&:to_f).sum / 2,
            satisfaction_percent: @reviews.where('(overall_rating + designer_rating) / 2 > 3').count * 100.0 / @reviews.count
          }
        end
      end
    end
  end
end
