# frozen_string_literal: true

class BrandDnaSerializer < ActiveModel::Serializer
  attributes :id,
             :bold_or_refined,
             :detailed_or_clean,
             :handcrafted_or_minimalist,
             :low_income_or_high_income,
             :masculine_or_premium,
             :outmoded_actual,
             :serious_or_playful,
             :stand_out_or_not_from_the_crowd,
             :traditional_or_modern,
             :value_or_premium,
             :youthful_or_mature,
             :target_country_codes
end
