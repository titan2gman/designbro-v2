# frozen_string_literal: true

module NewProject
  class StepBaseForm < BaseForm
    attribute :upgrade_project_state, Boolean
    attribute :step, ProjectBuilderStep

    private

    def validate_form?
      upgrade_project_state
    end

    def update_step
      return unless upgrade_project_state

      project.current_step = next_step
      project.save!
      project.finish_creation! unless next_step
    end

    def next_step
      @next_step ||= find_next_step
    end

    def find_next_step
      if project.contest?
        if project.brand.has_paid_project
          step.lower_items.mandatory_for_existing_brand.first
        else
          step.lower_item
        end
      elsif project.payments.any?
        if project.brand.has_paid_project
          step.lower_items.mandatory_for_existing_brand.mandatory_for_one_to_one_project.first
        else
          step.lower_items.mandatory_for_one_to_one_project.first
        end
      else
        step.lower_item
      end
    end
  end
end
