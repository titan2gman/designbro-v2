# frozen_string_literal: true

class WinnerCreator
  include Callable
  include Wisper::Publisher

  def initialize(design)
    @spot    = design.spot
    @project = design.project
  end

  def call
    @project.finalist_stage! if @project.design_stage?

    @spot.mark_as_winner!

    # pay money to dropped out finalists
    EarningCreator::PayFinalists.call(@project)

    # send mails to all dropped out designs as eliminated
    @project.designs.finalist.each do |design|
      DesignerMailer.design_not_selected_as_winner(design: design).deliver_later
    end

    # transition to files stage
    @project.select_winner!

    # sends DesignerStats data via WebSocket
    broadcast(:send_designer_stats_entity)
  end
end
