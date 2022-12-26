# frozen_string_literal: true

class FaqGroup < ApplicationRecord
  has_many :faq_items, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :faq_items, allow_destroy: true
end
