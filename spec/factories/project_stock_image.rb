# frozen_string_literal: true

FactoryBot.define do
  factory :project_stock_image do
    project
    stock_image
    comment { Faker::Lorem.sentence }
  end
end
