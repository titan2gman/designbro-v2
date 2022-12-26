class AddPayouInfoToPayout < ActiveRecord::Migration[5.0]
  def change
    add_column :payouts, :country, :string
    add_column :payouts, :payout_method, :string
    add_column :payouts, :paypal_account_number, :string
    add_column :payouts, :iban, :string
    add_column :payouts, :swift, :string
    add_column :payouts, :first_name, :string
    add_column :payouts, :last_name, :string
    add_column :payouts, :address1, :string
    add_column :payouts, :address2, :string
    add_column :payouts, :city, :string
    add_column :payouts, :state, :string
    add_column :payouts, :phone, :string
  end
end
