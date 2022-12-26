# frozen_string_literal: true

class Testimonial < ApplicationRecord
  validates :header, :body, :rating, :credential, :company, presence: true
  validates :rating, numericality: {
    integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }

  def self.random_record
    order(Arel.sql('random()')).limit(1).first
  end
end
