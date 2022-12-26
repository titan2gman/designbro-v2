class CreateProjectSourceFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :project_source_files do |t|
      t.references :designer, foreign_key: true
      t.references :project, foreign_key: true
      t.references :source_file, foreign_key: { to_table: :uploaded_files }
    end
  end
end
