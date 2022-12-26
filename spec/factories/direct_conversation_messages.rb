# frozen_string_literal: true

FactoryBot.define do
  factory :direct_conversation_message do
    user
    design

    text { Faker::Lorem.sentence }
  end
end
