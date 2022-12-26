# frozen_string_literal: true

class Payout < ApplicationRecord
  include Wisper::Publisher
  include Transactionable
  include AASM

  belongs_to :designer

  after_save :generate_payout_id, if: -> { payout_id.nil? }

  validates :city,
            :amount,
            :country,
            :address1,
            :last_name,
            :first_name,
            :payout_method, presence: true

  validate :enough_earnings_for_payout, on: :create

  scope :paypal, -> { where(payout_method: 'paypal') }

  aasm column: :payout_state do
    state :in_progress, initial: true
    state :paid
    state :canceled
    state :error

    event :pay do
      transitions from: :in_progress, to: :paid
    end

    event :error do
      transitions from: :in_progress, to: :error
    end

    event :cancel do
      transitions from: :in_progress, to: :canceled
    end
  end

  def send_payout_request_email
    broadcast(:payout_request, self)
  end

  private

  def generate_payout_id
    update(payout_id: generate_transaction_id)
  end

  def enough_earnings_for_payout
    errors.add(:base, 'Not enough earnings for payout') if amount && amount < PayoutMinAmount.first&.amount.to_i
  end
end
