# frozen_string_literal: true

FactoryBot.define do
  factory :login do
    ip { Faker::Internet.ip_v4_address }
    origin { Faker::Internet.url }
    user
  end
end
