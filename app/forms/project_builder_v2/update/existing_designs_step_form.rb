# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class ExistingDesignsStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :existing_designs, Array

      private

      def persist!
        update_project!
        update_step
      end

      def update_project!
        project.update(
          existing_designs_attributes: existing_designs
        )
      end
    end
  end
end
