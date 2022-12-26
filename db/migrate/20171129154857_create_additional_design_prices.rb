class CreateAdditionalDesignPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :additional_design_prices do |t|
      t.belongs_to :project_price, null: false
      t.integer :quantity, null: false
      t.monetize :amount

      t.timestamps
    end

    add_index :additional_design_prices, [:project_price_id, :quantity], unique: true
  end
end
