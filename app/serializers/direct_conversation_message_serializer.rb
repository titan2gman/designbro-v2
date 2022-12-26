# frozen_string_literal: true

class DirectConversationMessageSerializer < ActiveModel::Serializer
  attributes :name, :display_name, :text, :created_at, :user_id, :message_attached_files

  # has_many :message_attached_files, serializer: MessageAttachedFileSerializer, include: '**'

  def name
    object.user.name
  end

  def display_name
    user = object.user

    return user.client.first_name if user.client?
    return user.designer.display_name if user.designer?

    ''
  end

  def user_id
    object.user.id
  end

  def message_attached_files
    object.message_attached_files.map do |messageAttachedFile|
      {
        file: messageAttachedFile.file.url,
        original_filename: messageAttachedFile.original_filename,
        extension: messageAttachedFile.original_filename.split('.')[1],
      }
    end
  end
end
