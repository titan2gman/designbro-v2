class DeletePaymentAndPayoutConstraints < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:payments, :payment_id, true)
    change_column_null(:payouts, :payout_id, true)
  end
end
