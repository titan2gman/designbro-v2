# frozen_string_literal: true

class PayoutForm < ObjectBaseForm
  presents :payout

  private

  def persist!
    return unless payout.update(params)

    designer.earnings.earned.map(&:request_payout!)
    payout.send_payout_request_email
  end

  def params
    {
      amount: designer.available_for_payout
    }
  end
end
