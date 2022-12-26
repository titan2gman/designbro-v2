class CreateBillingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :billing_addresses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address1, null: false
      t.string :address2, null: false
      t.string :country, null: false
      t.string :city, null: false

      t.string :company
      t.string :phone
      t.string :state
      t.string :vat
      t.string :zip

      t.timestamps
    end
  end
end
