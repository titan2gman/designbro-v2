# frozen_string_literal: true

class PortfolioWorkSerializer < ActiveModel::Serializer
  attributes :description, :designer_id, :product_category_id, :url, :uploaded_file_id

  def url
    object&.uploaded_file&.file_url
  end

  def uploaded_file_id
    object&.uploaded_file&.id
  end
end
