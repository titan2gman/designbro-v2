# frozen_string_literal: true

FactoryBot.define do
  factory :earning do
    designer
    project
    amount { Faker::Number.between(from: 30_000, to: 50_000) }
  end
end
