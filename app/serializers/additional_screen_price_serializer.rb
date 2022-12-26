# frozen_string_literal: true

class AdditionalScreenPriceSerializer < ActiveModel::Serializer
  attributes :quantity, :amount, :amount_cents, :product_id

  belongs_to :product

  def amount
    object.amount.to_f
  end
end
