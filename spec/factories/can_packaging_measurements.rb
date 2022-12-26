# frozen_string_literal: true

FactoryBot.define do
  factory :can_packaging_measurements do
    height { "#{Faker::Number.decimal(l_digits: 2)} cm" }
    volume { "#{Faker::Number.decimal(l_digits: 2)} cm" }
    diameter { "#{Faker::Number.decimal(l_digits: 2)} cm" }

    technical_drawing
  end
end
