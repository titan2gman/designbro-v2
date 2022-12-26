# frozen_string_literal: true

FactoryBot.define do
  factory :project_color do
    hex { Faker::Color.hex_color }

    project
  end
end
