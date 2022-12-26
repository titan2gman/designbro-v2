# frozen_string_literal: true

class NdaPriceSerializer < ActiveModel::Serializer
  attributes :nda_type, :price, :price_cents

  def price
    object.price.to_f
  end
end
