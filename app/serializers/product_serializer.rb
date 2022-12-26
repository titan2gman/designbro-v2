# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :short_name,
             :key,
             :description,
             :price,
             :price_cents,
             :one_to_one_price,
             :one_to_one_price_cents,
             :active,
             :brand_name_hint,
             :brand_additional_text_hint,
             :brand_background_story_hint,
             :product_text_label,
             :product_text_hint,
             :what_is_it_for_label,
             :what_is_it_for_hint,
             :product_size_label,
             :product_size_hint,
             :product_category_name

  belongs_to :product_category

  has_many :additional_design_prices
  has_many :additional_screen_prices
  has_many :project_builder_steps
  has_many :project_brief_components

  def price
    object.price.to_f
  end
end
