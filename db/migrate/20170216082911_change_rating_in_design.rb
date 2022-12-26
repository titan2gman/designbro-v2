class ChangeRatingInDesign < ActiveRecord::Migration[5.0]
  def change
    change_column :designs, :rating, :integer, default: 0
  end
end
