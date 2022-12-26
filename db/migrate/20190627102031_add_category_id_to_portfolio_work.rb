class AddCategoryIdToPortfolioWork < ActiveRecord::Migration[5.2]
  def change
    add_reference :portfolio_works, :product_category, index: true, foreign_key: true

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE portfolio_works
          SET product_category_id = product_categories.id
          FROM product_categories
          WHERE portfolio_works.work_type = 0 AND product_categories.name = 'Brand Identity';
        SQL

        execute <<-SQL
          UPDATE portfolio_works
          SET product_category_id = product_categories.id
          FROM product_categories
          WHERE portfolio_works.work_type = 1 AND product_categories.name = 'Packaging';
        SQL
      end

      dir.down do
      end
    end

    remove_column :portfolio_works, :work_type, :integer, null: false
  end
end
