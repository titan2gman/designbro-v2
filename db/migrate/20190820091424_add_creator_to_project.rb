class AddCreatorToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :creator, foreign_key: { to_table: :clients }

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE projects
          SET creator_id = clients.id
          FROM brand_dnas, brands, companies, clients
          WHERE projects.brand_dna_id = brand_dnas.id AND brand_dnas.brand_id = brands.id AND brands.company_id = clients.company_id;
        SQL
      end

      dir.down do
      end
    end
  end
end
