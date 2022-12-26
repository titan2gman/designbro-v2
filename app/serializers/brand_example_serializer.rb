# frozen_string_literal: true

class BrandExampleSerializer < ActiveModel::Serializer
  type :brand_examples

  attributes :id, :original_filename, :url

  def url
    object.file.url
  end
end
