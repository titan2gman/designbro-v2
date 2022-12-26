class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :key
      t.monetize :price, currency: { present: false }
      t.references :product_category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
