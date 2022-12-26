# frozen_string_literal: true

class Payment < ApplicationRecord
  include Transactionable

  belongs_to :project

  has_one :client, through: :project

  enum payment_type: { credit_card: 0, paypal: 1, bank_transfer: 2 }
  enum paid_for: { project: 0, additional_spots: 1, additional_time: 2 }, _prefix: true

  after_save :generate_payment_id, if: -> { payment_id.nil? }

  validates :project, :payment_type, presence: true

  delegate :price, to: :project

  monetize :total_price_paid_cents
  monetize :nda_price_paid_cents
  monetize :vat_price_paid_cents
  monetize :discount_amount_saved_cents

  monetize :processing_fee_cents
  monetize :processing_fee_vat_cents

  scope :find_by_client, ->(client) { joins(:client).where(clients: { id: client }) }

  alias amount price

  private

  def generate_payment_id
    update(payment_id: generate_transaction_id)
  end
end
