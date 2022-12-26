# frozen_string_literal: true

FactoryBot.define do
  factory :pouch_packaging_measurements do
    height { "#{Faker::Number.decimal(l_digits: 2)} cm" }
    width { "#{Faker::Number.decimal(l_digits: 2)} cm" }

    technical_drawing
  end
end
