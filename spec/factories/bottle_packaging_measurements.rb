# frozen_string_literal: true

FactoryBot.define do
  factory :bottle_packaging_measurements do
    label_height { "#{Faker::Number.decimal(2)} cm" }
    label_width { "#{Faker::Number.decimal(2)} cm" }

    technical_drawing
  end
end
