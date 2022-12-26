# frozen_string_literal: true

FactoryBot.define do
  factory :faq_group do
    name { Faker::Lorem.sentence }
  end
end
