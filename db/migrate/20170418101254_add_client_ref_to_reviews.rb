class AddClientRefToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :design, foreign_key: true, null: false, index: { unique: true }
    add_reference :reviews, :client, foreign_key: true, null: false

    remove_column :reviews, :designer_id
  end
end
