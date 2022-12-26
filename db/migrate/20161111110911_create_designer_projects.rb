class CreateDesignerProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :designer_projects do |t|
      t.references :designer, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
