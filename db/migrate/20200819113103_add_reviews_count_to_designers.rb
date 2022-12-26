class AddReviewsCountToDesigners < ActiveRecord::Migration[5.2]
  def self.up
    add_column :designers, :reviews_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :designers, :reviews_count
  end
end
