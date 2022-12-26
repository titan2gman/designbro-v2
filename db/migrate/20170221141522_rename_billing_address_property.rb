class RenameBillingAddressProperty < ActiveRecord::Migration[5.0]
  def change
    change_table :billing_addresses do |t|
      t.rename :country, :country_code
    end
  end
end
