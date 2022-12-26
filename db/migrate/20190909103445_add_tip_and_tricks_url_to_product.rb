class AddTipAndTricksUrlToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :tip_and_tricks_url, :string

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE products
          SET tip_and_tricks_url = 'https://designbro.com/how-to-get-your-logo/'
          WHERE products.key = 'logo';
        SQL

        execute <<-SQL
          UPDATE products
          SET tip_and_tricks_url = 'https://designbro.com/how-to-get-your-brand-identity/'
          WHERE products.key = 'brand-identity';
        SQL

        execute <<-SQL
          UPDATE products
          SET tip_and_tricks_url = 'https://designbro.com/how-to-get-your-packaging-design/'
          WHERE products.key = 'packaging';
        SQL

        execute <<-SQL
          UPDATE products
          SET tip_and_tricks_url = 'https://designbro.com/how-to-get-your-website-design/'
          WHERE products.key = 'website';
        SQL
      end

      dir.down do
      end
    end
  end
end
