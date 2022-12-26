# frozen_string_literal: true

class ApprovePortfolioJob < ApplicationJob
  def perform(designer_id, count_of_approved_states)
    designer = Designer.find(designer_id)

    DesignerMailer.portfolio_approved(user: designer.user).deliver_now if count_of_approved_states == designer.count_of_approved_states
  end
end
