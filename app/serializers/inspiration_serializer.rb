# frozen_string_literal: true

class InspirationSerializer < ActiveModel::Serializer
  attributes :url, :comment, :uploaded_file_id

  def url
    object.inspiration_image&.file&.url
  end

  def uploaded_file_id
    object.inspiration_image&.id&.to_s
  end
end
