# frozen_string_literal: true

class PayoutSerializer < ActiveModel::Serializer
  attributes :created_at, :payout_id, :amount, :payout_state

  def amount
    object.amount / 100
  end
end
