# frozen_string_literal: true

class ProjectSourceFileSerializer < ActiveModel::Serializer
  attributes :url, :filename, :created_at, :file_size, :extension

  belongs_to :project

  def url
    object.source_file.file.url
  end

  def created_at
    object.source_file.created_at
  end

  def file_size
    object.source_file.file.size.to_f / (1024 * 1024)
  end

  def extension
    object.source_file.file.file.extension
  end

  def filename
    object.source_file.original_filename.chomp(".#{extension}")
  end
end
