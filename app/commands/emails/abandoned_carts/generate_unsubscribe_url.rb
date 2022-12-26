# frozen_string_literal: true

module Emails
  module AbandonedCarts
    class GenerateUnsubscribeUrl
      def initialize(project)
        @project = project
      end

      def call
        return unless project

        Rails.application
             .routes
             .url_helpers
             .emails_abandoned_cart_unsubscribe_url(host: ENV.fetch('ROOT_URL'),
                                                    token: generate_token)
      end

      private

      attr_reader :project

      def generate_token
        ActiveSupport::MessageEncryptor.new(secret_key).encrypt_and_sign(project.id)
      end

      def secret_key
        Rails.application.secrets.secret_key_base[0, 32]
      end
    end
  end
end
