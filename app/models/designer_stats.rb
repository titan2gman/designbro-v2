# frozen_string_literal: true

class DesignerStats
  include Serializable

  def initialize(designer)
    @designer = designer
  end

  def id
    @designer.id
  end

  def in_progress_count
    projects_in_progress.count
  end

  def finalists_count
    @designer.spots.finalist_states.count
  end

  def winners_count
    @designer.spots.winner.count
  end

  def expired_spots_percentage
    expired_spots_count = @designer.spots.expired.count
    all_spots_count = @designer.spots.where.not(state: :in_queue).count
    all_spots_count.zero? ? 0 : (100 * expired_spots_count.to_f / all_spots_count).round
  end

  def available_for_payout
    @designer.available_for_payout / 100
  end

  private

  def projects_in_progress
    @projects_in_progress ||= begin
      DesignerProjectsQuery::InProgress.call(
        @designer.projects
      )
    end
  end
end
