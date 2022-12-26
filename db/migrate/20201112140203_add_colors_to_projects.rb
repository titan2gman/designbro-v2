class AddColorsToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :new_colors, :json, null: false, default: []
  end
end
