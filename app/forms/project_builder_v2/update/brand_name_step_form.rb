# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class BrandNameStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :brand_name, String

      validates :brand_name, presence: true, if: :validate_form?

      private

      def persist!
        update_brand!
        update_step
      end

      def update_brand!
        existing_brand = project.company&.brands&.find_by(name: brand_name)

        if existing_brand
          project.brand.destroy! unless project.brand.projects.any?
          project.update!(brand_dna: existing_brand.brand_dnas.last)
        else
          project.brand.update!(
            name: brand_name
          )
        end
      end
    end
  end
end
