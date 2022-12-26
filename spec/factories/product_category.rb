# frozen_string_literal: true

FactoryBot.define do
  factory :product_category do
    name { ProductCategory.pluck(:name).sample }
    initialize_with { ProductCategory.find_or_initialize_by(name: name) }
  end
end
