class AddProductToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :product, index: true, foreign_key: true

    reversible do |dir|
      dir.up do
        category = ProductCategory.find_or_create_by!(name: 'Brand Identity')
        p = Product.find_or_create_by!(name: 'Logo', key: 'logo', product_category: category)
        p.update(price: 199)
        p = Product.find_or_create_by!(name: 'Brand Identity', key: 'brand-identity', product_category: category)
        p.update(price: 399)

        category = ProductCategory.find_or_create_by!(name: 'Packaging')
        p = Product.find_or_create_by!(name: 'Packaging', key: 'packaging', product_category: category)
        p.update(price: 599)

        execute <<-SQL
          UPDATE projects
          SET product_id = products.id
          FROM products
          WHERE projects.project_type = 0 AND products.name = 'Logo';
        SQL

        execute <<-SQL
          UPDATE projects
          SET product_id = products.id
          FROM products
          WHERE projects.project_type = 1 AND products.name = 'Brand Identity';
        SQL

        execute <<-SQL
          UPDATE projects
          SET product_id = products.id
          FROM products
          WHERE projects.project_type = 2 AND products.name = 'Packaging';
        SQL
      end

      dir.down do
      end
    end

    remove_column :projects, :project_type, :integer, index: true
  end
end
