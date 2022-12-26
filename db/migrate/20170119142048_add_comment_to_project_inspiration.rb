class AddCommentToProjectInspiration < ActiveRecord::Migration[5.0]
  def change
    add_column :project_inspirations, :comment, :string
  end
end
