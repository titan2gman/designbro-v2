class DuplidateReviews < ActiveRecord::Migration[5.2]
  def up
    execute "UPDATE reviews SET overall_rating = designer_rating, overall_comment = designer_comment;"
  end

  def down
  end
end
