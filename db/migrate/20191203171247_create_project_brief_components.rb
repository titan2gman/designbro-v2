class CreateProjectBriefComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :project_brief_components do |t|
      t.string :attribute_name
      t.string :component_name

      t.integer :position

      t.references :product

      t.timestamps
    end
  end
end
