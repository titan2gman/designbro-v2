# frozen_string_literal: true

module NewProject
  class ExamplesStepForm < NewProject::StepBaseForm
    presents :project

    REQUIRED_GOOD_EXAMPLES_COUNT = 3

    attribute :client, Client

    attribute :bad_examples, Array
    attribute :good_examples, Array
    attribute :skip_examples, Array

    validate :good_examples_count, if: :validate_form?

    private

    def persist!
      brand_examples = [:skip, :good, :bad].inject([]) do |array, brand_example_type|
        array + (public_send "#{brand_example_type}_examples").map do |brand_example_id|
          { id: brand_example_id, type: brand_example_type }
        end
      end

      project.brand_examples = brand_examples.map do |brand_example|
        project_brand_example = project.brand_examples.where(brand_example_id: brand_example[:id]).first_or_initialize
        project_brand_example.assign_attributes(example_type: brand_example[:type])
        project_brand_example
      end

      project.save!

      update_step
    end

    def good_examples_count
      if good_examples.size < REQUIRED_GOOD_EXAMPLES_COUNT
        diff = REQUIRED_GOOD_EXAMPLES_COUNT - good_examples.size

        if diff == 1
          errors.add(:good_examples, :select_1_more_item)
        else
          errors.add(:good_examples, :select_n_more_items, count: diff)
        end
      end
    end
  end
end
