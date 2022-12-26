class CreatePayoutMinAmounts < ActiveRecord::Migration[5.0]
  def change
    create_table :payout_min_amounts do |t|
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
