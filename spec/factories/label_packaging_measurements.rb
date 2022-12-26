# frozen_string_literal: true

FactoryBot.define do
  factory :label_packaging_measurements do
    label_height { "#{Faker::Number.decimal(l_digits: 2)} cm" }
    label_width { "#{Faker::Number.decimal(l_digits: 2)} cm" }

    technical_drawing
  end
end
