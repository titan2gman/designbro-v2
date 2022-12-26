# frozen_string_literal: true

FactoryBot.define do
  factory :abandoned_cart_discount do
    association :discount
  end
end
