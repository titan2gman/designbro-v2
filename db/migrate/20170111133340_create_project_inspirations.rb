class CreateProjectInspirations < ActiveRecord::Migration[5.0]
  def change
    create_table :project_inspirations do |t|
      t.references :project, foreign_key: true

      t.references :inspiration_image, foreign_key: { to_table: :uploaded_files }
    end
  end
end
