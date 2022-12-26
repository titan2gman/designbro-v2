# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    product
    brand_dna

    creator { company.clients.first }

    design_type { Project.design_types.keys.sample }
    design_stage_started_at { Time.zone.now }
    finalist_stage_started_at { Time.zone.now }
    files_stage_started_at { Time.zone.now }
    review_files_stage_started_at { Time.zone.now }

    design_stage_expires_at { Time.current + design_stage_expire_duration }
    finalist_stage_expires_at { Time.current + finalist_stage_expire_duration }
    files_stage_expires_at { Time.current + files_stage_expire_duration }
    review_files_stage_expires_at { Time.current + review_files_stage_expire_duration }

    ideas_or_special_requirements { Faker::Lorem.sentence }
    front_business_card_details { Faker::Lorem.sentence }
    back_business_card_details { Faker::Lorem.sentence }
    colors_comment { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    what_to_design { Faker::Lorem.sentence }
    state { 'design_stage' }
    letter_head { Faker::Lorem.sentence }
    compliment { Faker::Lorem.sentence }
    max_spots_count { 3 }
    product_text { Faker::Lorem.sentence }
    what_is_it_for { Faker::Lorem.sentence }

    sequence(:name) do |index|
      "Project ##{index} (With NDA)"
    end

    upgrade_package { false }
    type_price { 123 }

    discount
    discount_amount { 100 }

    transient do
      good_examples_count { 3 }
    end

    before(:create) do |project, evaluator|
      options = { project: project, example_type: :good }
      project.brand_examples = create_list(:project_brand_example, evaluator.good_examples_count, options)
    end

    factory :real_project do
      type_price { product.price }

      before(:create) do |project|
        create(:payment, project: project)
      end
    end

    trait :with_measurements do
      before(:create) do |project|
        project.packaging_measurements = create(:can_packaging_measurements)
      end
    end

    factory :project_without_company do
      association :brand_dna, factory: :brand_dna_without_company
      creator { nil }
    end

    # factory :project_without_good_examples, parent: :project_without_company do
    #   state { 'draft' }
    #   before(:create) do |project|
    #     project.brand_examples = []
    #   end
    # end
  end
end
