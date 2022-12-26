# frozen_string_literal: true

class OneToOnePaymentReceivedJob < ApplicationJob
  def perform(project_id)
    project = Project.find_by(id: project_id)

    ClientMailer.one_to_one_payment_received(project: project).deliver_now if project&.draft?
  end
end
