# frozen_string_literal: true

class ProjectAdditionalDocumentSerializer < ActiveModel::Serializer
  attributes :comment, :url, :created_at, :file_size, :extension, :filename, :uploaded_file_id

  def url
    object.additional_document.file.url
  end

  def created_at
    object.additional_document.created_at
  end

  def file_size
    object.additional_document.file.size.to_f / (1024 * 1024)
  end

  def extension
    object.additional_document.file.file.extension
  end

  def filename
    object.additional_document.original_filename.chomp(".#{extension}")
  end

  def uploaded_file_id
    object.additional_document.id.to_s
  end
end
