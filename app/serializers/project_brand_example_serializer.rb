# frozen_string_literal: true

class ProjectBrandExampleSerializer < ActiveModel::Serializer
  attributes :url, :example_type, :project_id

  belongs_to :brand_example

  def url
    object.brand_example.file.url
  end
end
