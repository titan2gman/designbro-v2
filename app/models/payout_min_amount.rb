# frozen_string_literal: true

class PayoutMinAmount < ApplicationRecord
  validates :amount, presence: true
end
