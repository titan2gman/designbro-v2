# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class IdeasOrSpecialRequirementsStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :ideas_or_special_requirements, String

      private

      def persist!
        update_project
        update_step
      end

      def update_project
        project.update(
          ideas_or_special_requirements: ideas_or_special_requirements
        )
      end
    end
  end
end
