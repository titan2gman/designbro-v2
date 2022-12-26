# frozen_string_literal: true

FactoryBot.define do
  factory :abandoned_cart_reminder do
    name { Project::REMINDER_ACTIVE_STATES.sample }
    sequence :step do |n|
      n
    end
    minutes_to_reminder { rand(1..3600) }
  end
end
