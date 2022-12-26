class AddAnswersToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :designer_comment_answer, :text
    add_column :reviews, :overall_comment_answer, :text
  end
end
