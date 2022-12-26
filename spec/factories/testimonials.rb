# frozen_string_literal: true

FactoryBot.define do
  factory :testimonial do
    header     { Faker::Lorem.sentence }
    body       { Faker::Lorem.sentence }
    rating     { Faker::Number.between(from: 1, to: 5) }
    credential { Faker::Name.name }
    company    { Faker::Company.name }
  end
end
