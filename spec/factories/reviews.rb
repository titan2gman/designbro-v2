# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    client
    design

    designer_comment { Faker::Lorem.sentence }
    designer_rating  { Faker::Number.between(from: 1, to: 5) }

    overall_comment { Faker::Lorem.sentence }
    overall_rating  { Faker::Number.between(from: 1, to: 5) }
  end
end
