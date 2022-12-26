class CreateAbandonedCartDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :abandoned_cart_discounts do |t|
      t.references :discount
      t.timestamps
    end
  end
end
