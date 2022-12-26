# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class AdditionalTextStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :brand_additional_text, String

      private

      def persist!
        update_brand
        update_step
      end

      def update_brand
        project.brand.update(
          additional_text: brand_additional_text
        )
      end
    end
  end
end
