# frozen_string_literal: true

class CompetitorForm < BaseForm
  presents :competitor

  attribute :name, String
  attribute :website, String
  attribute :comment, String
  attribute :rate, Integer

  attribute :validate_form, Boolean

  validates :name, presence: true, if: :validate_form

  validates :rate, presence: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    only_integer: true
  }, if: :validate_form

  def persist!
    competitor.assign_attributes(
      website: website,
      comment: comment,
      name: name,
      rate: rate
    )

    competitor.save
  end
end
