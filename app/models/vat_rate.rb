# frozen_string_literal: true

class VatRate < ApplicationRecord
  validates :country_name, :percent, presence: true

  validates :country_code,
            presence: true,
            uniqueness: true
end
