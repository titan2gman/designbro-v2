class ChangeProjectExistingLogos < ActiveRecord::Migration[5.2]
  def change
    rename_table :project_existing_logos, :existing_designs
    add_reference :existing_designs, :brand, index: true, foreign_key: true

    # UploadedFile::InspirationImage.where(entity_type: "ProjectExistingLogo").update_all(
    #   entity_type: "ExistingDesign"
    # )

    # ExistingDesign.find_each do |logo|
    #   project = Project.find(logo.project_id)

    #   logo.update!(
    #     brand_id: project.brand_id
    #   )
    # end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE uploaded_files
          SET entity_type = 'ExistingDesign'
          WHERE entity_type = 'ProjectExistingLogo';
        SQL

        execute <<-SQL
          UPDATE existing_designs
          SET brand_id = brand_dnas.brand_id
          FROM projects, brand_dnas
          WHERE existing_designs.project_id = projects.id AND projects.brand_dna_id = brand_dnas.id;
        SQL
      end

      dir.down do
      end
    end

    remove_reference :existing_designs, :project, index: true, foreign_key: true
  end
end
