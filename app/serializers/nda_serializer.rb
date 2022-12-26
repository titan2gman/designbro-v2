# frozen_string_literal: true

class NdaSerializer < ActiveModel::Serializer
  attributes :nda_type, :value, :price_cents, :paid
end
