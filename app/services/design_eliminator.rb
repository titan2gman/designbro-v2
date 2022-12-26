# frozen_string_literal: true

class DesignEliminator
  include Callable

  def initialize(design)
    @design = design
  end

  def call(eliminate_design_params)
    return unless @design.can_be_eliminated?

    @design.update!(eliminate_design_params)
    @design.eliminate!

    # mark next spot in queue as reserved
    QueueSpotReserver.new(project: @design.project).call

    @design
  end
end
