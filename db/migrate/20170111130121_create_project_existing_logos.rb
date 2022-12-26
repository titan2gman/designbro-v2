class CreateProjectExistingLogos < ActiveRecord::Migration[5.0]
  def change
    create_table :project_existing_logos do |t|
      t.string :comment

      t.references :project, foreign_key: true
      t.references :existing_logo, foreign_key: { to_table: :uploaded_files }
    end
  end
end
