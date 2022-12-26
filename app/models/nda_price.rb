# frozen_string_literal: true

class NdaPrice < ApplicationRecord
  enum nda_type: {
    standard: 0,
    custom: 1,
    free: 2
  }

  monetize :price_cents

  validates :nda_type, uniqueness: true
end
