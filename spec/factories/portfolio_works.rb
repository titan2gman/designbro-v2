# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio_work do
    description { Faker::Lorem.sentence }
    uploaded_file { create(:designer_portfolio_work) }

    designer
    product_category
  end
end
