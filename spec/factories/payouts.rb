# frozen_string_literal: true

FactoryBot.define do
  factory :payout do
    designer

    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }

    address1 { Faker::Address.street_address }
    address2 { Faker::Address.street_address }

    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    phone { Faker::PhoneNumber.phone_number }

    payout_method { 'paypal' }
    amount { Faker::Number.between(from: 30_000, to: 50_000) }
    paypal_email { Faker::Internet.email }
  end
end
