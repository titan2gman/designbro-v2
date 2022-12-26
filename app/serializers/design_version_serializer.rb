# frozen_string_literal: true

class DesignVersionSerializer < ActiveModel::Serializer
  type 'designVersions'
  attributes :image

  def id
    object.uploaded_file.id
  end

  def image
    object.uploaded_file.file_url
  end
end
