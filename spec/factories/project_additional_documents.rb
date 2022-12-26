# frozen_string_literal: true

FactoryBot.define do
  factory :project_additional_document do
    comment { Faker::Lorem.sentence }

    additional_document
    project
  end
end
