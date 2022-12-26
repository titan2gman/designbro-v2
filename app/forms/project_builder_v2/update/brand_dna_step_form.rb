# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class BrandDnaStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :brand_dna_bold_or_refined, Integer
      attribute :brand_dna_detailed_or_clean, Integer
      attribute :brand_dna_handcrafted_or_minimalist, Integer
      attribute :brand_dna_serious_or_playful, Integer
      attribute :brand_dna_stand_out_or_not_from_the_crowd, Integer
      attribute :brand_dna_traditional_or_modern, Integer
      attribute :brand_dna_value_or_premium, Integer

      private

      def persist!
        update_brand_dna
        update_step
      end

      def update_brand_dna
        project.brand_dna.update(
          bold_or_refined: brand_dna_bold_or_refined,
          value_or_premium: brand_dna_value_or_premium,
          detailed_or_clean: brand_dna_detailed_or_clean,
          serious_or_playful: brand_dna_serious_or_playful,
          traditional_or_modern: brand_dna_traditional_or_modern,
          handcrafted_or_minimalist: brand_dna_handcrafted_or_minimalist,
          stand_out_or_not_from_the_crowd: brand_dna_stand_out_or_not_from_the_crowd
        )
      end
    end
  end
end
