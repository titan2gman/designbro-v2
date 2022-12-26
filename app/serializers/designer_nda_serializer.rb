# frozen_string_literal: true

class DesignerNdaSerializer < ActiveModel::Serializer
  attributes :created_at

  has_one :nda
  has_one :brand
end
