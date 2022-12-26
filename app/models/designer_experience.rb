# frozen_string_literal: true

class DesignerExperience < ApplicationRecord
  include AASM

  belongs_to :designer
  belongs_to :product_category

  validates :experience, presence: true

  enum experience: {
    no_experience: 0,
    junior_experience: 1,
    middle_experience: 2,
    senior_experience: 3
  }

  aasm(:state) do
    state :draft, initial: true
    state :pending
    state :approved
    state :disapproved

    event :upload_works do
      transitions from: [:draft, :disapproved], to: :pending
    end

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :disapprove do
      transitions from: [:pending, :approved], to: :disapproved
    end
  end
end
