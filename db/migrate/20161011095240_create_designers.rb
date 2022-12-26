class CreateDesigners < ActiveRecord::Migration[5.0]
  def change
    create_table :designers do |t|
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.string :country
      t.integer :age
      t.integer :gender
      t.integer :experience_brand
      t.integer :experience_packaging
      t.integer :experience_english
      t.boolean :portfolio_uploaded, null: false, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
