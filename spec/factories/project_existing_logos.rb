# frozen_string_literal: true

FactoryBot.define do
  factory :project_existing_logo do
    comment { Faker::Lorem.sentence }

    existing_logo
    project
  end
end
