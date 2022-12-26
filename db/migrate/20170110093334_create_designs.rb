class CreateDesigns < ActiveRecord::Migration[5.0]
  def change
    create_table :designs do |t|
      t.references :uploaded_file
      t.references :designer, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
