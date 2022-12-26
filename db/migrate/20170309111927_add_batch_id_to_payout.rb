class AddBatchIdToPayout < ActiveRecord::Migration[5.0]
  def change
    add_column :payouts, :paypal_batch_id, :string
  end
end
