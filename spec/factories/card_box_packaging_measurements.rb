# frozen_string_literal: true

FactoryBot.define do
  factory :card_box_packaging_measurements do
    front_height { "#{Faker::Number.decimal(l_digits: 2)} cm" }
    front_width { "#{Faker::Number.decimal(l_digits: 2)} cm" }
    side_depth { "#{Faker::Number.decimal(l_digits: 2)} cm" }

    technical_drawing
  end
end
