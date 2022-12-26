# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    company_name { Faker::Company.name }
    address1 { Faker::Address.secondary_address }
    address2 { nil }
    city { Faker::Address.city }
    country_code { Faker::Address.country_code }
    state_name { Faker::Address.state }
    zip { Faker::Address.zip }
    phone { Faker::PhoneNumber.cell_phone }
    vat { nil }

    transient do
      clients_count { 1 }
    end

    after(:create) do |company, evaluator|
      create_list(:client, evaluator.clients_count, company: company)
    end
  end
end
