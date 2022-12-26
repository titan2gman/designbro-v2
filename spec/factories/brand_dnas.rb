# frozen_string_literal: true

FactoryBot.define do
  factory :brand_dna do
    bold_or_refined { Faker::Number.between(from: 0, to: 10) }
    detailed_or_clean { Faker::Number.between(from: 0, to: 10) }
    handcrafted_or_minimalist { Faker::Number.between(from: 0, to: 10) }
    low_income_or_high_income { Faker::Number.between(from: 0, to: 10) }
    masculine_or_premium { Faker::Number.between(from: 0, to: 10) }
    outmoded_actual { Faker::Number.between(from: 0, to: 10) }
    serious_or_playful { Faker::Number.between(from: 0, to: 10) }
    stand_out_or_not_from_the_crowd { Faker::Number.between(from: 0, to: 10) }
    traditional_or_modern { Faker::Number.between(from: 0, to: 10) }
    value_or_premium { Faker::Number.between(from: 0, to: 10) }
    youthful_or_mature { Faker::Number.between(from: 0, to: 10) }
    target_country_codes { [Faker::Address.country_code] }

    brand
  end

  factory :brand_dna_without_company, parent: :brand_dna do
    association :brand, factory: :brand_without_company
  end
end
