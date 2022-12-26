# frozen_string_literal: true

FactoryBot.define do
  factory :designer do
    sequence :display_name do |index|
      "#{Faker::Name.first_name}#{index}"
    end

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 99) }
    gender { Designer.genders.keys.sample }
    experience_english { Designer.experience_englishes.keys.sample }

    portfolio_uploaded { true }
    max_active_spots_count { Faker::Number.non_zero_digit }

    country_code { Faker::Address.country_code }
    address1 { Faker::Address.street_address }
    address2 { nil }
    city { Faker::Address.city }
    state_name { Faker::Address.state }
    zip { Faker::Address.zip }
    phone { Faker::PhoneNumber.phone_number }

    user

    factory :designer_with_approved_experience do
      after(:create) do |designer|
        ProductCategory.find_each do |category|
          create(:approved_designer_experience, product_category: category, designer: designer)
        end
      end
    end
  end
end
