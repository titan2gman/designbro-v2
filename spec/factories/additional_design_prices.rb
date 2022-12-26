# frozen_string_literal: true

FactoryBot.define do
  factory :additional_design_price do
    amount { Faker::Commerce.price }
    quantity { rand(3..10) }

    product
  end
end
