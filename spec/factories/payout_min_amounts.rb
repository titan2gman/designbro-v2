# frozen_string_literal: true

FactoryBot.define do
  factory :payout_min_amount do
    amount { Faker::Number.between(from: 10_000, to: 25_000) }
  end
end
