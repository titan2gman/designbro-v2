# frozen_string_literal: true

class VatRateSerializer < ActiveModel::Serializer
  attributes :country_name, :country_code, :percent
end
