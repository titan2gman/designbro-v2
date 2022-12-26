# frozen_string_literal: true

class ProjectStockImageSerializer < ActiveModel::Serializer
  attributes :comment, :url, :created_at, :file_size, :extension, :filename, :uploaded_file_id

  def url
    object.stock_image.file.url
  end

  def created_at
    object.stock_image.created_at
  end

  def file_size
    object.stock_image.file.size.to_f / (1024 * 1024)
  end

  def extension
    object.stock_image.file.file.extension
  end

  def filename
    object.stock_image.original_filename.chomp(".#{extension}")
  end

  def uploaded_file_id
    object.stock_image.id.to_s
  end
end
