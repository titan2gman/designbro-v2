class CreateProjectPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :project_prices do |t|
      t.integer :normalized_price, null: false, default: 0

      t.integer :project_type, null: false

      t.timestamps
    end
  end
end
