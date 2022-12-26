class AddTimestampToReview < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :reviews, null: true
  end
end
