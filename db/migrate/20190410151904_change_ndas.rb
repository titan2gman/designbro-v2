class ChangeNdas < ActiveRecord::Migration[5.2]
  def change
    add_reference :ndas, :brand, index: true, foreign_key: true
    add_column :ndas, :start_date, :datetime
    add_column :ndas, :expiry_date, :datetime

    # Nda.find_each do |nda|
    #   project = Project.find(nda.project_id)

    #   nda.update!(
    #     brand_id: project.brand_id
    #   )
    # end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE ndas
          SET brand_id = brand_dnas.brand_id
          FROM projects, brand_dnas
          WHERE ndas.project_id = projects.id AND projects.brand_dna_id = brand_dnas.id;
        SQL
      end

      dir.down do
      end
    end

    remove_reference :ndas, :project, index: true, foreign_key: true
  end
end
