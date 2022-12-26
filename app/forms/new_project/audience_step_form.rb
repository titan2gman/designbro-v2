# frozen_string_literal: true

module NewProject
  class AudienceStepForm < NewProject::StepBaseForm
    presents :project

    attribute :brand_dna_target_country_codes, Array

    attribute :brand_dna_youthful_or_mature, Integer
    attribute :brand_dna_masculine_or_premium, Integer
    attribute :brand_dna_low_income_or_high_income, Integer

    validates :id, presence: true

    validates :brand_dna_youthful_or_mature,
              :brand_dna_masculine_or_premium,
              :brand_dna_low_income_or_high_income,
              presence: true,
              inclusion: 0..10

    private

    def persist!
      project.brand_dna.update!(
        youthful_or_mature: brand_dna_youthful_or_mature,
        masculine_or_premium: brand_dna_masculine_or_premium,
        low_income_or_high_income: brand_dna_low_income_or_high_income,
        target_country_codes: brand_dna_target_country_codes
      )

      update_step
    end
  end
end
