# frozen_string_literal: true

class PublicReviewSerializer < ActiveModel::Serializer
  attributes  :id,
              :average_rating,
              :overall_rating,
              :designer_rating,
              :overall_comment,
              :overall_comment_answer,
              :designer_comment,
              :designer_comment_answer,
              :created_at,
              :product_key,
              :product_name,
              :product_category,
              :brand_name,
              :client_name,
              :company_name,
              :company_country,
              :designer_name,
              :spots_sold,
              :total_designs_uploaded,
              :featured_image_url

  def average_rating
    (object.designer_rating + object.overall_rating) / 2.0
  end

  def product_key
    object.design.project.product.key
  end

  def product_name
    object.design.project.product.name
  end

  def product_category
    object.design.project.product.product_category.name
  end

  def brand_name
    object.design.project.brand_dna.brand.name
  end

  def client_name
    object.client.first_name
  end

  def company_name
    object.client.company.name
  end

  def spots_sold
    object.design.project.max_spots_count
  end

  def total_designs_uploaded
    object.design.project.spots_with_uploaded_design.length
  end

  def company_country
    ISO3166::Country.new(object.client.company.country_code)&.name
  end

  def designer_name
    object.designer.name
  end

  def featured_image_url
    object.design.project.featured_image&.uploaded_featured_image&.file&.url
  end
end
