class ChangeProjectCompetitors < ActiveRecord::Migration[5.2]
  def change
    rename_table :project_competitors, :competitors
    add_reference :competitors, :brand, index: true, foreign_key: true

    # UploadedFile::InspirationImage.where(entity_type: "ProjectCompetitor").update_all(
    #   entity_type: "Competitor"
    # )

    # Competitor.find_each do |compatitor|
    #   project = Project.find(compatitor.project_id)

    #   compatitor.update!(
    #     brand_id: project.brand_id
    #   )
    # end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE uploaded_files
          SET entity_type = 'Competitor'
          WHERE entity_type = 'ProjectCompetitor';
        SQL

        execute <<-SQL
          UPDATE competitors
          SET brand_id = brand_dnas.brand_id
          FROM projects, brand_dnas
          WHERE competitors.project_id = projects.id AND projects.brand_dna_id = brand_dnas.id;
        SQL
      end

      dir.down do
      end
    end

    remove_reference :competitors, :project, index: true, foreign_key: true
  end
end
