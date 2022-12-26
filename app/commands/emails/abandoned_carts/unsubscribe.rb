# frozen_string_literal: true

module Emails
  module AbandonedCarts
    class Unsubscribe
      CLIENT_NOT_FOUND_URL = '/errors/404'
      SUCCSESSFULLY_UNSUBSCRIBED_URL = '/emails/abandoned-cart/unsubscribe'

      def initialize(token)
        @token = token
      end

      def call
        decode_project_from_token
        fetch_client
        return not_found_url unless client

        unsubscribe_client
        succsefully_unsubscribed_url
      end

      private

      attr_reader :client, :token, :project

      def decode_project_from_token
        project_id = ActiveSupport::MessageEncryptor.new(secret_key).decrypt_and_verify(token)
        @project = Project.find_by(id: project_id)
      rescue ActiveSupport::MessageVerifier::InvalidSignature
        nil
      end

      def fetch_client
        # TODO: fix for all clients
        @client = @project&.clients&.first
      end

      def not_found_url
        "#{root_url}#{CLIENT_NOT_FOUND_URL}"
      end

      def succsefully_unsubscribed_url
        "#{root_url}#{SUCCSESSFULLY_UNSUBSCRIBED_URL}?#{project_params.to_query}"
      end

      def project_params
        { projectName: project.name }
      end

      def unsubscribe_client
        client.update_column(:opt_out, true)
      end

      def root_url
        @root_url ||= ENV.fetch('ROOT_URL')
      end

      def secret_key
        Rails.application.secrets.secret_key_base[0, 32]
      end
    end
  end
end
