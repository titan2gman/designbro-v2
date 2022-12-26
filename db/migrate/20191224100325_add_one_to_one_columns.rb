class AddOneToOneColumns < ActiveRecord::Migration[5.2]
  def change
    add_monetize :products, :one_to_one_price

    add_column :project_builder_steps, :required_for_one_to_one, :boolean, null: false, default: false

    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TYPE project_type AS ENUM ('contest', 'one_to_one');
        SQL

        add_column :projects, :project_type, :project_type, null: false, default: 'contest'
      end

      dir.down do
        remove_column :projects, :project_type

        execute <<-SQL
          DROP TYPE project_type;
        SQL
      end
    end
  end
end
