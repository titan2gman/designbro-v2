class AddShareSourceFilesToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :source_files_shared, :boolean, null: false, default: false
  end
end
