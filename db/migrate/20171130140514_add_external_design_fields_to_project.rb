class AddExternalDesignFieldsToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :max_designs_count, :integer, default: 3, null: false

    Project.update_all(max_designs_count: 10)
  end
end
