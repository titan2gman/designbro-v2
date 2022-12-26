class RemoveFieldsFromBillingAddress < ActiveRecord::Migration[5.0]
  def change
    remove_column :billing_addresses, :address1
    remove_column :billing_addresses, :address2
    remove_column :billing_addresses, :phone
    remove_column :billing_addresses, :state
    remove_column :billing_addresses, :city
    remove_column :billing_addresses, :zip
  end
end
