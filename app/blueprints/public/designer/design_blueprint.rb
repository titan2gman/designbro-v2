# frozen_string_literal: true

class Public::Designer::DesignBlueprint < Blueprinter::Base
  has_free_nda = ->(_field_name, spot, _options) { spot.project.active_nda&.nda_type == 'free' }

  identifier :id

  fields :state

  field :created_at do |spot|
    spot&.design&.created_at
  end

  field :nda_type do |spot|
    spot.project.active_nda&.nda_type
  end

  field :brand_name, if: has_free_nda do |spot|
    spot.project.brand_dna.brand.name
  end

  field :brand_description, if: has_free_nda do |spot|
    spot.project.brand_dna.brand.description
  end

  field :total_price, if: has_free_nda do |spot|
    spot.project.price
  end

  field :spots_count, if: has_free_nda do |spot|
    spot.project.max_spots_count
  end

  field :designs_count, if: has_free_nda do |spot|
    spot.project.designs.length
  end

  field :product do |spot|
    spot.project.product.name
  end

  field :product_category do |spot|
    spot.project.product.product_category.name
  end

  field :company_country do |spot|
    ISO3166::Country.new(spot.project.company.country_code)&.name
  end

  field :url do |spot|
    spot.project.featured_image&.uploaded_featured_image&.file&.url || spot.design&.uploaded_file&.file&.url
  end
end
