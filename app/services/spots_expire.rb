# frozen_string_literal: true

class SpotsExpire
  def call
    Spot.of_contest_project.reserved.without_design.each do |spot|
      if spot.reservation_expired?
        spot.expire!
        QueueSpotReserver.new(project: spot.project).call

      elsif spot.send_12_hours_of_reservation_left_warning?
        DesignerMailer.reservation_12_hours_left(user: spot.designer.user, project: spot.project).deliver_later
      end
    end
  end
end
