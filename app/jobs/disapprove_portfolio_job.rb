# frozen_string_literal: true

class DisapprovePortfolioJob < ApplicationJob
  def perform(designer_id, count_of_disapproved_states)
    designer = Designer.find(designer_id)

    DesignerMailer.portfolio_disapproved(user: designer.user).deliver_now if count_of_disapproved_states == designer.count_of_disapproved_states
  end
end
