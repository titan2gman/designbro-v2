class AddDetailsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :description, :text

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE products
          SET description = 'Get your logo designed by our professional designers.'
          WHERE key = 'logo'
        SQL

        execute <<-SQL
          UPDATE products
          SET description = 'Includes custom design for: logo, business card, letterhead, envelope, and compliment slip.'
          WHERE key = 'brand-identity'
        SQL

        execute <<-SQL
          UPDATE products
          SET description = 'Includes a flat graphic design for your packaging shape. Includes all sides and logo if needed.'
          WHERE key = 'packaging'
        SQL
      end

      dir.down do
      end
    end
  end
end
