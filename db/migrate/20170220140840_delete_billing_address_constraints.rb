class DeleteBillingAddressConstraints < ActiveRecord::Migration[5.0]
  def change
    change_column_null :billing_addresses, :first_name, true
    change_column_null :billing_addresses, :last_name, true
    change_column_null :billing_addresses, :address1, true
    change_column_null :billing_addresses, :country, true
    change_column_null :billing_addresses, :city, true
  end
end
