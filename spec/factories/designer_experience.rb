# frozen_string_literal: true

FactoryBot.define do
  factory :designer_experience do
    experience { DesignerExperience.experiences.keys.sample }
    state { [:draft, :pending, :approved].sample }

    product_category
    designer

    factory :approved_designer_experience do
      state { :approved }
    end
  end
end
