# frozen_string_literal: true

FactoryBot.define do
  factory :faq_item do
    name { Faker::Lorem.sentence }
    answer { Faker::Lorem.paragraph }

    faq_group
  end
end
