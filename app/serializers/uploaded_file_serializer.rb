# frozen_string_literal: true

class UploadedFileSerializer < ActiveModel::Serializer
  attributes :entity_id, :entity_type, :original_filename, :file

  def file
    object.file.url
  end
end
