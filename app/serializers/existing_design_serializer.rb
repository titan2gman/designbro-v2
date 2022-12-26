# frozen_string_literal: true

class ExistingDesignSerializer < ActiveModel::Serializer
  attributes :comment, :url, :extension, :file_size, :uploaded_file_id

  def url
    object.existing_logo.file.url
  end

  def extension
    object.existing_logo.file.file.extension
  end

  def file_size
    object.existing_logo.file.size.to_f / (1024 * 1024)
  end

  def uploaded_file_id
    object.existing_logo.id.to_s
  end
end
