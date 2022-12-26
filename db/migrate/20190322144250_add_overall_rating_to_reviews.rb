class AddOverallRatingToReviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :rating, :designer_rating
    rename_column :reviews, :comment, :designer_comment

    add_column :reviews, :overall_rating, :integer, default: 0, null: false
    add_column :reviews, :overall_comment, :string
  end
end
