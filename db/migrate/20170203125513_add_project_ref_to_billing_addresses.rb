class AddProjectRefToBillingAddresses < ActiveRecord::Migration[5.0]
  def change
    add_reference :billing_addresses, :project, foreign_key: true, null: false
  end
end
