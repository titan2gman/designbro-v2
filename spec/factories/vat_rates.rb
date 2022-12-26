# frozen_string_literal: true

FactoryBot.define do
  factory :vat_rate, class: VatRate do
    country_name { ISO3166::Country.new(country_code).translations['en'] }
    country_code { Faker::Address.country_code }
    percent { 25 }

    factory :united_kingdom_vat_rate do
      country_code { 'GB' }
    end
  end
end
