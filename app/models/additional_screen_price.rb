# frozen_string_literal: true

class AdditionalScreenPrice < ApplicationRecord
  belongs_to :product

  monetize :amount_cents

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
end
