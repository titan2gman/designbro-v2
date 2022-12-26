# frozen_string_literal: true

class SetDesignerHeroImageJob < ApplicationJob
  def perform
    Designer.joins(:winner_spots).where(hero_image: nil).uniq.each do |designer|
      featured_image = designer.winner_spots.joins(
        project: [:featured_image, :active_nda]
      ).where(
        ndas: { nda_type: Nda.nda_types[:free] }
      ).where.not(
        featured_images: { id: nil }
      ).order(created_at: :desc).last&.project&.featured_image

      designer.update(hero_image: featured_image) if featured_image
    end
  end
end
