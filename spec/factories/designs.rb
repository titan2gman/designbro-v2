# frozen_string_literal: true

FactoryBot.define do
  factory :design do
    sequence :name do |index|
      "Design ##{index}"
    end

    rating { Faker::Number.between(from: 1, to: 5) }

    # project
    spot do
      create(
        :reserved_spot,
        designer: designer || create(:designer),
        project: project || create(:project)
      )
    end

    uploaded_file { create(:design_file) }

    after(:create) do |design|
      design.spot.upload_design!
    end

    factory :eliminated_design do
      after(:create) do |design|
        design.spot.eliminate!
      end
    end

    factory :stationery_design do
      spot do
        create(
          :reserved_spot,
          designer: designer || create(:designer),
          project: project || create(:project)
        )
      end

      after(:create) do |design|
        design.spot.mark_as_finalist!
      end

      factory :stationery_uploaded_design do
        after(:create) do |design|
          design.spot.upload_stationery!
        end
      end
    end

    factory :finalist_design do
      after(:create) do |design|
        design.spot.mark_as_finalist!

        if design.project.brand_identity?
          design.spot.upload_stationery!
          design.spot.approve_stationery!
        end
      end

      factory :winner_design do
        after(:create) do |design|
          design.spot.mark_as_winner!
        end
      end
    end
  end
end
