# frozen_string_literal: true

class BrandExampleBlueprint < Blueprinter::Base
  identifier :id

  field :url do |brand_example|
    brand_example.file.url
  end
end
