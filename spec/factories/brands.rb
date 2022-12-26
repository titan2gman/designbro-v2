# frozen_string_literal: true

FactoryBot.define do
  factory :brand do
    name { Faker::Name.name }
    slogan { Faker::Lorem.sentence }
    additional_text { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    background_story { Faker::Lorem.sentence }
    where_it_is_used { Faker::Lorem.sentence }
    what_is_special { Faker::Lorem.sentence }

    company

    factory :brand_without_company do
      company { nil }
    end

    after(:create) do |brand|
      create(:free_nda, brand: brand, paid: true)
    end
  end
end
