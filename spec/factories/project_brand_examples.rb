# frozen_string_literal: true

FactoryBot.define do
  factory :project_brand_example do
    example_type { ProjectBrandExample.example_types.keys.sample }

    brand_example
    project
  end
end
