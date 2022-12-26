class RenameMaxDesignCountForProject < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :max_designs_count, :max_spots_count
  end
end
