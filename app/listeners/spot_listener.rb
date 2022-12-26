# frozen_string_literal: true

class SpotListener
  def design_eliminated(design)
    QueueSpotReserver.new(project: design.project).call
    DesignerMailer.design_eliminated(design: design).deliver_later
  end

  def design_eliminated_by_admin(design)
    QueueSpotReserver.new(project: design.project).call
  end

  def spot_reserved(spot)
    DesignerMailer.spot_reserved(spot: spot).deliver_later
  end
end
