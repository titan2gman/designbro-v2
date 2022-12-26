class AddColoursCommentToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :colours_comment, :string
  end
end
