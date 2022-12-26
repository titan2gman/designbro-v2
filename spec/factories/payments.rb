# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    payment_type { [:credit_card, :paypal].sample }

    project

    factory :credit_card_payment do
      payment_type { :credit_card }
    end
  end
end
