class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :designer, foreign_key: true, index: true
      t.string :comment, null: false
      t.integer :rating, default: 0, null: false
    end
  end
end
