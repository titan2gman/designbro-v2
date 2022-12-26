# frozen_string_literal: true

FactoryBot.define do
  factory :discount do
    code { DiscountCodeGenerator.new.call }
    discount_type { Discount.discount_types.keys.sample }
    value { rand(10..20) }

    begin_date { Time.zone.now }
    end_date { Time.zone.now + 10.days }

    max_num { rand(5..10) }

    Discount.discount_types.each_key do |type|
      factory :"#{type}_discount" do
        discount_type { type }
      end
    end
  end
end
