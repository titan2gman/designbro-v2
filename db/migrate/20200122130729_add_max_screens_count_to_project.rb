class AddMaxScreensCountToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :max_screens_count, :integer, default: 1, null: false
  end
end
