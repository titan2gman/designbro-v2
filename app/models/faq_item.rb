# frozen_string_literal: true

class FaqItem < ApplicationRecord
  belongs_to :faq_group

  validates :name, :answer, presence: true
end
