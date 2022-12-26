# frozen_string_literal: true

class Earning < ApplicationRecord
  include AASM

  belongs_to :designer
  belongs_to :project

  validates :amount, :project, :designer, presence: true

  aasm column: :state do
    state :earned, initial: true
    state :paid
    state :designer_deleted

    event :request_payout do
      transitions from: :earned, to: :paid
    end

    event :deleted_designer do
      transitions from: :earned, to: :designer_deleted
    end
  end
end
