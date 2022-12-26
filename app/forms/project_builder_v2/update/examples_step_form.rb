# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class ExamplesStepForm < ProjectBuilderV2::Update::BaseForm
      presents :project

      attribute :brand_example_ids, Array

      # validates :brand_name, presence: true, if: :validate_form?

      private

      def persist!
        update_project!
        update_step
      end

      def update_project!
        project.new_brand_examples.where.not(example_id: brand_example_ids).destroy_all

        (brand_example_ids - project.new_brand_examples.pluck(:example_id)).each do |id|
          BrandExample.create!(project: project, example_id: id)
        end
      end
    end
  end
end
