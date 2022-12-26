class AddAverageRatingToDesigners < ActiveRecord::Migration[5.2]
  def change
    add_column :designers, :average_rating, :decimal, precision: 3, scale: 2
  end
end
