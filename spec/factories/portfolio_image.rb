# frozen_string_literal: true

FactoryBot.define do
  factory :portfolio_image do
    uploaded_file { create(:portfolio_image_file) }
  end
end
