# frozen_string_literal: true

module Projects
  module AbandonedCartReminders
    class Send
      def initialize(project)
        @project = project
      end

      def call
        return if project.reminding_completed?

        project.clients.each do |client|
          AbandonedCartMailer.public_send(
            :"abandoned_cart_#{reminder_step}",
            project: project,
            client: client,
            reminder_step: reminder_step
          ).deliver_later
        end
      end

      private

      attr_reader :project

      def reminder_step
        project.abandoned_cart_reminder_step.to_s
      end
    end
  end
end
