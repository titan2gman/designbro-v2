# frozen_string_literal: true

class PortfolioImageSerializer < ActiveModel::Serializer
  attributes :image

  def image
    object.uploaded_file.file_url(:thumb)
  end
end
