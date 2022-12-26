# frozen_string_literal: true

class Public::Designer::ReviewBlueprint < Blueprinter::Base
  has_free_nda = ->(_field_name, review, _options) { review.project.active_nda&.nda_type == 'free' }

  identifier :id

  fields :designer_rating, :designer_comment, :designer_comment_answer, :created_at

  field :nda_type do |review|
    review.project.active_nda&.nda_type
  end

  field :brand_name, if: has_free_nda do |review|
    review.project.brand_dna.brand.name
  end

  field :total_price, if: has_free_nda do |review|
    review.project.price
  end

  field :product do |review|
    review.project.product.name
  end

  field :debrief do |review|
    review.project.debrief
  end

  field :product_category do |review|
    review.project.product.product_category.name
  end

  field :company_country do |review|
    ISO3166::Country.new(review.project.company.country_code)&.name
  end

  field :client do |review|
    review.project.clients.first.first_name
  end
end
