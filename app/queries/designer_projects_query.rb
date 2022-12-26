# frozen_string_literal: true

module DesignerProjectsQuery
  class InProgress
    include Callable

    def initialize(projects)
      @projects = projects
    end

    def call
      @projects.where(state: Project::DESIGNER_IN_PROGRESS_STATES).merge(Spot.visible)
    end
  end

  class Completed
    include Callable

    def initialize(projects)
      @projects = projects
    end

    def call
      @projects.where(state: Project::DESIGNER_COMPLETED_STATES)
    end
  end
end
