# frozen_string_literal: true

class DirectConversationMessageCreator
  include Callable

  def initialize(direct_conversation_message, file_to_upload)
    @message = direct_conversation_message
    @file_to_upload = file_to_upload
  end

  def call
    last_message = @message.design.direct_conversation_messages.order(:created_at).last

    @message.seconds_since_last_message = (Time.now - last_message.created_at).seconds if last_message && last_message.user_id != @message.user_id

    @message.save!

    unless @file_to_upload.nil?
      @file_to_upload.each do |file|
        @messageAttachedFile = UploadedFile::MessageAttachedFile.new file: file
        @messageAttachedFile.entity = @message
        @messageAttachedFile.save
      end
    end

    # sends notification via WebSocket
    DirectConversationChannel.broadcast(@message)

    # sends notification via email
    UserMailer.new_chat_message_created(message: @message).deliver_later if @message.addressee&.notify_messages_received?
  end
end
