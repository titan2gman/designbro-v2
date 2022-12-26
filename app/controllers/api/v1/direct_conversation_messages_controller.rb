# frozen_string_literal: true

module Api
  module V1
    class DirectConversationMessagesController < Api::V1::ApplicationController
      load_and_authorize_resource :design

      load_and_authorize_resource through: :design

      def index
        respond_with @direct_conversation_messages
      end

      def create
        DirectConversationMessageCreator.call(
          @direct_conversation_message,
          params[:fileToUpload]
        )

        respond_with @direct_conversation_message
      end

      private

      def direct_conversation_message_params
        params.permit(:text)
      end
    end
  end
end
