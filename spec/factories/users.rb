# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'secret123' }
    state { 'pending' }
    confirmed_at { Time.now }
    inform_on_email { 'once a day' }
    notify_news { true }
    notify_messages_received { true }
    notify_projects_updates { true }
  end
end
