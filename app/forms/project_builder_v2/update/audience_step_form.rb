# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class AudienceStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :brand_dna_youthful_or_mature, Integer
      attribute :brand_dna_masculine_or_premium, Integer
      attribute :brand_dna_low_income_or_high_income, Integer

      attribute :brand_dna_target_country_codes, Array

      private

      def persist!
        update_brand_dna
        attach_client!
        update_step
      end

      def update_brand_dna
        project.brand_dna.update(
          youthful_or_mature: brand_dna_youthful_or_mature,
          masculine_or_premium: brand_dna_masculine_or_premium,
          low_income_or_high_income: brand_dna_low_income_or_high_income,
          target_country_codes: brand_dna_target_country_codes
        )
      end
    end
  end
end
