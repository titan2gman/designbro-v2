# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class CompetitorsStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :competitors, Array

      private

      def persist!
        update_project!
        update_step
      end

      def update_project!
        project.brand.update(
          competitors_attributes: competitors
        )
      end
    end
  end
end
