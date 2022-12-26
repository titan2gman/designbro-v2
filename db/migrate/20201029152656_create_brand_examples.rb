class CreateBrandExamples < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_examples do |t|
      t.references :project, foreign_key: true
      t.references :example, foreign_key: { to_table: :uploaded_files }

      t.timestamps
    end
  end
end
