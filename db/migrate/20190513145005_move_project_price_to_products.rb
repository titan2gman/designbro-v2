class MoveProjectPriceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :additional_design_prices, :product, index: true, foreign_key: true

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE additional_design_prices
          SET product_id = products.id
          FROM products, project_prices
          WHERE additional_design_prices.project_price_id = project_prices.id AND project_prices.project_type = 0 AND products.name = 'Logo';
        SQL

        execute <<-SQL
          UPDATE additional_design_prices
          SET product_id = products.id
          FROM products, project_prices
          WHERE additional_design_prices.project_price_id = project_prices.id AND project_prices.project_type = 1 AND products.name = 'Brand Identity';
        SQL

        execute <<-SQL
          UPDATE additional_design_prices
          SET product_id = products.id
          FROM products, project_prices
          WHERE additional_design_prices.project_price_id = project_prices.id AND project_prices.project_type = 2 AND products.name = 'Packaging';
        SQL
      end

      dir.down do
      end
    end

    remove_reference :additional_design_prices, :project_price, index: true

    drop_table :project_prices
  end
end
