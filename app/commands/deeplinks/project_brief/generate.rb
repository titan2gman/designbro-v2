# frozen_string_literal: true

module Deeplinks
  module ProjectBrief
    class Generate
      def initialize(client, project)
        @client = client
        @project = project
      end

      attr_reader :project

      def call
        return unless client

        Rails.application.routes.url_helpers.continue_brief_url(host: ENV.fetch('ROOT_URL'), project_id: project.id, token: generate_token, reminder: project.abandoned_cart_reminder_step)
      end

      private

      attr_reader :client

      def generate_token
        JsonWebToken.encode(client_id: client.id)
      end
    end
  end
end
