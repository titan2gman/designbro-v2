# frozen_string_literal: true

module ProjectBuilderV2
  module Update
    class BaseForm < ::BaseForm
      attribute :upgrade_project_state, Boolean
      attribute :step, ProjectBuilderStep
      attribute :client, Object

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

      def attach_client!
        project.brand.update!(company: client.company) if client && !project.brand.company
        project.update!(creator: client) if client && !project.creator
      end

      def find_next_step
        step.lower_item
      end
    end
  end
end
