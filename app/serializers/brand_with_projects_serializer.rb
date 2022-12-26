# frozen_string_literal: true

class BrandWithProjectsSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :slogan,
             :additional_text,
             :description,
             :background_story,
             :where_it_is_used,
             :what_is_special,
             :has_nda

  belongs_to :company

  has_many :projects
  has_many :ndas
  has_many :competitors

  def has_nda
    object.active_nda_not_free?
  end
end
