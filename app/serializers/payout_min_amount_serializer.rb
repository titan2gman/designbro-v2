# frozen_string_literal: true

class PayoutMinAmountSerializer < ActiveModel::Serializer
  attributes :amount

  def amount
    object.amount / 100
  end
end
