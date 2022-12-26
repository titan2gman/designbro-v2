# frozen_string_literal: true

FactoryBot.define do
  factory :start_notification_request do
    email { Faker::Internet.email }
  end
end
