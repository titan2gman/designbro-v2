class AddEmailToPayout < ActiveRecord::Migration[5.0]
  def change
    add_column :payouts, :paypal_email, :string
    remove_column :payouts, :paypal_account_number
  end
end
