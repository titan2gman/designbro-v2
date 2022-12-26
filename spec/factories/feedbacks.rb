# frozen_string_literal: true

FactoryBot.define do
  factory :feedback do
    name { Faker::Lorem.sentence }
    email { Faker::Internet.email }
    subject { Faker::Lorem.sentence }
    message { Faker::Lorem.sentence }
  end
end
