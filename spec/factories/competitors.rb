# frozen_string_literal: true

FactoryBot.define do
  factory :competitor do
    name { Faker::Company.name }
    website { Faker::Internet.url }
    comment { Faker::Lorem.sentence }
    rate { Faker::Number.between(from: 1, to: 5) }

    competitor_logo
    brand
  end
end
