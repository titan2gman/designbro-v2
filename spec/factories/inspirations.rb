# frozen_string_literal: true

FactoryBot.define do
  factory :inspiration do
    comment { Faker::Lorem.sentence }

    inspiration_image
    brand
  end
end
