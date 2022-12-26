# frozen_string_literal: true

class Nda < ApplicationRecord
  enum nda_type: {
    standard: 0,
    custom: 1,
    free: 2
  }

  monetize :price_cents

  belongs_to :brand

  has_many :designer_ndas, dependent: :destroy

  scope :not_free, -> { where.not(nda_type: :free) }

  def not_free?
    !free?
  end
end
