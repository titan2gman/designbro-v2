class CreatePayouts < ActiveRecord::Migration[5.0]
  def change
    create_table :payouts do |t|
      t.references :designer
      t.string :payout_id
      t.integer :amount, default: 0
      t.timestamps
    end
  end
end
