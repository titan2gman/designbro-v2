# frozen_string_literal: true

class ProductCategorySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :full_name

  has_many :products
end
