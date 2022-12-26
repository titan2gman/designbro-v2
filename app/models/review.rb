# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :design
  belongs_to :client

  has_one :designer, through: :design
  has_one :project, through: :design

  counter_culture [:design, :spot, :designer] # , column_name: :reviews_count

  validates :design,
            :client,
            :designer_rating,
            :designer_comment,
            :overall_rating,
            :overall_comment, presence: true

  validates :design, uniqueness: true

  validates :designer_rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    only_integer: true
  }

  validates :overall_rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5,
    only_integer: true
  }
end
