# frozen_string_literal: true

class ReserveSpotForm < ObjectBaseForm
  include Wisper::Publisher

  presents :spot

  private

  def persist!
    return unless project.can_be_reserved?

    if project.available_spots_reserved?(designer)
      project.errors.add(:project, 'You have already reserved two spots')
    elsif designer.max_active_spots_count && designer.max_active_spots_count <= designer.active_spots_count
      project.errors.add(:project, "You've reached the maximum amount of active spots")
    elsif project.has_available_spot_for?(designer)
      spot.reserve!
    elsif project.queue_available_for?(designer)
      spot.queue!
    end
  end
end
