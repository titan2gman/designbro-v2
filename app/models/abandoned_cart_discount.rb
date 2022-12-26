# frozen_string_literal: true

class AbandonedCartDiscount < ApplicationRecord
  belongs_to :discount, optional: true
end
