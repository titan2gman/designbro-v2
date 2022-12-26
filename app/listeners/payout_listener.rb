# frozen_string_literal: true

class PayoutListener
  def payout_request(payout)
    PayoutMailer.payout_request(payout: payout).deliver_later
  end
end
