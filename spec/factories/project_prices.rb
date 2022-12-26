# frozen_string_literal: true

FactoryBot.define do
  factory :project_price do
    price { Faker::Commerce.price }

    [:logo, :packaging, :brand_identity].each do |project_type|
      factory :"#{project_type}_project_price" do
        project_type { project_type }
      end
    end
  end
end
