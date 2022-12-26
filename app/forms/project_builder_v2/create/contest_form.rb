# frozen_string_literal: true

module ProjectBuilderV2
  module Create
    class ContestForm < ProjectBuilderV2::Create::BaseForm
      presents :project

      private

      def persist!
        update_project!
      end

      def update_project!
        project.update!(
          product: product,
          project_type: project_type,
          current_step: current_step,
          brand_dna: brand_dna,
          referrer: referrer,
          creator: client
        )
      end

      def project_type
        'contest'
      end

      def current_step
        if brand.has_paid_project
          product.project_builder_steps.mandatory_for_existing_brand.first
        else
          product.project_builder_steps.first
        end
      end
    end
  end
end
