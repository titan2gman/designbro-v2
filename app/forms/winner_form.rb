# frozen_string_literal: true

class WinnerForm
  include ActiveModel::Validations
  include Virtus.model

  attribute :design, Design

  validates :design, presence: true

  validate :design_state, if: :design

  private

  def design_state
    errors.add(:design, :be_finalist) unless design.finalist?
  end
end
