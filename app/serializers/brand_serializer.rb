# frozen_string_literal: true

class BrandSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :slogan,
             :additional_text,
             :description,
             :background_story,
             :where_it_is_used,
             :what_is_special

  belongs_to :company

  has_many :ndas
  has_many :competitors
end
