# frozen_string_literal: true

class QueueSpotReserver
  include Virtus.model

  attribute :project, Project

  def call
    project.spots.in_queue.order(created_at: :asc)
           .first(project.spots_available)
           .map(&:reserve!)
  end
end
