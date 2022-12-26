class CreateVatRates < ActiveRecord::Migration[5.0]
  def change
    create_table :vat_rates do |t|
      t.string :country_name, null: false, index: true
      t.string :country_code, null: false, index: true
      t.integer :percent, null: false

      t.timestamps
    end
  end
end
