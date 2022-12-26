# frozen_string_literal: true

class CalculateAverageRatingJob < ApplicationJob
  def perform
    Designer.includes(:reviews).where('reviews_count > 0').find_each do |designer|
      designer.update_columns(
        average_rating: (designer.reviews.sum(&:designer_rating) * 2.0 / designer.reviews.length.to_f).round / 2.0
      )
    end
  end
end
