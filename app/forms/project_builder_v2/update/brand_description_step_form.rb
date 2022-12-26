# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class BrandDescriptionStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :brand_description, String

      private

      def persist!
        update_brand
        update_step
      end

      def update_brand
        project.brand.update(
          description: brand_description
        )
      end
    end
  end
end
