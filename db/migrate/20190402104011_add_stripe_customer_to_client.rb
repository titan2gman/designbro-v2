class AddStripeCustomerToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :stripe_customer, :string
    add_column :clients, :is_last_charge_successful, :boolean
  end
end
