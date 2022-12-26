# frozen_string_literal: true

class DesignerStatsChannel < ApplicationCable::Channel
  CHANNEL_NAME = 'designer-stats-%<designer>s'
  def self.broadcast(designer_stats)
    data = ActiveModelSerializers::SerializableResource.new(designer_stats).as_json
    ActionCable.server.broadcast(format(CHANNEL_NAME, designer: designer_stats.id), data)
  end

  def subscribed
    stream_from(format(CHANNEL_NAME, designer: params[:designer]))
  end
end
