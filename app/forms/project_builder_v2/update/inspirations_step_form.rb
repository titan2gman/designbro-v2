# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class InspirationsStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :inspirations, Array

      private

      def persist!
        update_project!
        update_step
      end

      def update_project!
        project.update(
          inspirations_attributes: inspirations
        )
      end
    end
  end
end
