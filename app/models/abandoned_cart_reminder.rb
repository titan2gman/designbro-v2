# frozen_string_literal: true

class AbandonedCartReminder < ApplicationRecord
  validates :name, :step, :minutes_to_reminder, presence: true
  validates :name, uniqueness: true
  validates :name, inclusion: ['first_reminder', 'second_reminder', 'third_reminder']
  validates :step, :minutes_to_reminder, numericality: { only_integer: true,
                                                         greater_than_or_equal_to: 1 }
end
