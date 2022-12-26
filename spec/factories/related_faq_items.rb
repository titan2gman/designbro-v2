# frozen_string_literal: true

FactoryBot.define do
  factory :related_faq_item do
    faq_item

    association :related_faq_item, factory: :faq_item
  end
end
