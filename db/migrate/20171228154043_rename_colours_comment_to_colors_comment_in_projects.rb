class RenameColoursCommentToColorsCommentInProjects < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :colours_comment, :colors_comment
  end
end
