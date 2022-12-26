class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.string :code, null: false
      t.integer :discount_type, null: false
      t.integer :value, null: false
      t.datetime :begin_date, null: false
      t.datetime :end_date, null: false
      t.integer :used_num, null: false, default: 0
      t.integer :max_num, null: false

      t.timestamps
    end

    add_index :discounts, :code, unique: true
    add_index :discounts, :discount_type
  end
end
