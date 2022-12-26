# frozen_string_literal: true

class AdditionalDesignPrice < ApplicationRecord
  belongs_to :product

  monetize :amount_cents

  validates :quantity, numericality: { greater_than_or_equal_to: 4, less_than_or_equal_to: 10 }
  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
end
