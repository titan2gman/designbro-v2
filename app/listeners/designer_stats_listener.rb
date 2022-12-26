# frozen_string_literal: true

class DesignerStatsListener
  def send_designer_stats_entity(design)
    DesignerStatsChannel.broadcast(
      design.designer.stats
    )
  end

  alias designer_blocked      send_designer_stats_entity
  alias finalist_selected     send_designer_stats_entity
  alias design_was_eliminated send_designer_stats_entity
end
