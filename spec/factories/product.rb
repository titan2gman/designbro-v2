# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    key { Product.pluck(:key).sample }
    initialize_with { Product.find_or_initialize_by(key: key) }

    ['logo', 'packaging'].each do |key|
      factory :"#{key}_product" do
        key { key }
        initialize_with { Product.find_or_initialize_by(key: key) }
      end
    end
  end
end
