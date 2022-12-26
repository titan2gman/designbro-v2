class ChangeProjectColorsColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :new_colors, :jsonb, null: false, default: []
  end
end
