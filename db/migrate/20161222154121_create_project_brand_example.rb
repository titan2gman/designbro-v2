class CreateProjectBrandExample < ActiveRecord::Migration[5.0]
  def change
    create_table :project_brand_examples do |t|
      t.integer :example_type, index: true, null: false

      t.references :project, foreign_key: true
      t.references :brand_example, foreign_key: { to_table: :uploaded_files }
    end
  end
end
