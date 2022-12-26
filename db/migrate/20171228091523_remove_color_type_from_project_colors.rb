class RemoveColorTypeFromProjectColors < ActiveRecord::Migration[5.0]
  def change
    remove_column :project_colors, :color_type
  end
end
