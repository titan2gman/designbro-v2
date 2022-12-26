# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    preferred_payment_method { ['credit_card', 'paypal'].sample }
    user
    company

    factory :god_client do
      god { true }
    end
  end
end
