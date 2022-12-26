# frozen_string_literal: true

FactoryBot.define do
  factory :nda do
    nda_type    { Nda.nda_types.keys.sample }
    value       { Faker::Lorem.paragraph }
    price       { NdaPrice.find_or_create_by(attributes_for(:nda_price, nda_type: nda_type)).price }
    start_date  { Faker::Date.backward(days: 5) }
    expiry_date { Faker::Date.forward(days: 5) }

    paid { false }

    brand

    [:free, :custom, :standard].each do |type|
      factory :"#{type}_nda" do
        nda_type { type }
      end
    end
  end
end
