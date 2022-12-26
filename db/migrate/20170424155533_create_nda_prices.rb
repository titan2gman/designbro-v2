class CreateNdaPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :nda_prices do |t|
      t.integer :nda_type, null: false, unique: true
      t.monetize :price, null: false

      t.timestamps
    end
  end
end
