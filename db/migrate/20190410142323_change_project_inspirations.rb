class ChangeProjectInspirations < ActiveRecord::Migration[5.2]
  def change
    rename_table :project_inspirations, :inspirations

    add_reference :inspirations, :brand, index: true, foreign_key: true

    # UploadedFile::InspirationImage.where(entity_type: "ProjectInspiration").update_all(
    #   entity_type: "Inspiration"
    # )

    # Inspiration.find_each do |inspiration|
    #   project = Project.find(inspiration.project_id)

    #   inspiration.update!(
    #     brand_id: project.brand_id
    #   )
    # end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE uploaded_files
          SET entity_type = 'Inspiration'
          WHERE entity_type = 'ProjectInspiration';
        SQL

        execute <<-SQL
          UPDATE inspirations
          SET brand_id = brand_dnas.brand_id
          FROM projects, brand_dnas
          WHERE inspirations.project_id = projects.id AND projects.brand_dna_id = brand_dnas.id;
        SQL
      end

      dir.down do
      end
    end

    remove_reference :inspirations, :project, index: true, foreign_key: true
  end
end
