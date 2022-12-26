# frozen_string_literal: true

class DirectConversationChannel < ApplicationCable::Channel
  CHANNEL_NAME = 'direct-conversation-%<design>s'

  def self.broadcast(message)
    data = ActiveModelSerializers::SerializableResource.new(message).as_json
    ActionCable.server.broadcast(format(CHANNEL_NAME, design: message.design_id), data)
  end

  def subscribed
    stream_from(format(CHANNEL_NAME, design: params[:design]))
  end
end
