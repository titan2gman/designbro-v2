class AddFullNameToProductCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :product_categories, :full_name, :string

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE product_categories
          SET full_name = 'Brand Identity'
          WHERE product_categories.name = 'Brand Identity';
        SQL

        execute <<-SQL
          UPDATE product_categories
          SET full_name = 'Packaging'
          WHERE product_categories.name = 'Packaging';
        SQL

        execute <<-SQL
          UPDATE product_categories
          SET name = 'Online Media', full_name = 'Online Media (website, banners and others)'
          WHERE product_categories.name = 'Digital';
        SQL
      end

      dir.down do
      end
    end
  end
end
