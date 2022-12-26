class CreateProjectColors < ActiveRecord::Migration[5.0]
  def change
    create_table :project_colors do |t|
      t.integer :color_type, index: true, null: false
      t.string :hex
      t.references :project, foreign_key: true
    end
  end
end
