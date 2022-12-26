# frozen_string_literal: true

class Public::Designer::PortfolioBlueprint < Blueprinter::Base
  identifier :id

  fields :description

  field :size do |work|
    work.uploaded_file.file.size.to_f / (1024 * 1024)
  end

  field :url do |work|
    work.uploaded_file.file.url
  end

  field :product_category do |work|
    work.product_category.name
  end
end
