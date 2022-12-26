# frozen_string_literal: true

class FeaturedImageSerializer < ActiveModel::Serializer
  attributes :url, :uploaded_file_id

  def url
    object.uploaded_featured_image.file.url
  end

  def uploaded_file_id
    object.uploaded_featured_image.id.to_s
  end
end
