class AddPayoutStateToPayout < ActiveRecord::Migration[5.0]
  def change
    add_column :payouts, :payout_state, :string
    add_index :payouts, :payout_state
  end
end
