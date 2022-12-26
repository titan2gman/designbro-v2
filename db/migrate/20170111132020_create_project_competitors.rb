class CreateProjectCompetitors < ActiveRecord::Migration[5.0]
  def change
    create_table :project_competitors do |t|
      t.string :name
      t.string :website
      t.string :comment
      t.integer :rate
      t.references :project, foreign_key: true
      t.references :competitor_logo, foreign_key: {to_table: :uploaded_files}
    end
  end
end
