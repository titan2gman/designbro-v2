class CreateAdditionalScreenPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :additional_screen_prices do |t|
      t.references :product, null: false, foreign_key: true, index: true
      t.integer :quantity, null: false
      t.monetize :amount

      t.timestamps
    end
  end
end
