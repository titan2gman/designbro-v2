# frozen_string_literal: true

FactoryBot.define do
  factory :nda_price do
    nda_type { Nda.nda_types.keys.sample }
    price_cents do
      case nda_type
      when 'standard'
        2500
      when 'custom'
        9800
      else
        0
      end
    end

    initialize_with { NdaPrice.find_or_create_by(nda_type: nda_type) }

    [:standard, :custom, :free].each do |nda_type|
      factory :"#{nda_type}_nda_price" do
        nda_type { nda_type }
      end
    end
  end
end
