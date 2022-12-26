class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :state
      t.integer :project_type
      t.string :inspiration

      t.timestamps
    end
    add_index :projects, :state
    add_index :projects, :project_type
  end
end
