class AddExpireTimeToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :design_stage_expire_days, :integer, :default => 10, null: false
    add_column :products, :finalist_stage_expire_days, :integer, :default => 5, null: false
    add_column :products, :files_stage_expire_days, :integer, :default => 3, null: false
    add_column :products, :review_files_stage_expire_days, :integer, :default => 10, null: false
    add_column :products, :reservation_expire_days, :integer, :default => 1, null: false

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE products
          SET design_stage_expire_days = 12
          WHERE products.key = 'packaging' OR products.key = 'website';
        SQL

        execute <<-SQL
          UPDATE products
          SET finalist_stage_expire_days = 7
          WHERE products.key = 'brand-identity' OR products.key = 'website';
        SQL

        execute <<-SQL
          UPDATE products
          SET reservation_expire_days = 2
          WHERE products.key = 'website' OR products.key = 'packaging';
        SQL
      end

      dir.down do
      end
    end
  end
end
