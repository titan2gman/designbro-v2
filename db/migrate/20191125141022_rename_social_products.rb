class RenameSocialProducts < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE products
          SET description = 'Get an original post for your instagram account, or get a professional designer to determine what your #instastyle should be!'
          WHERE products.key = 'instagram-post';
        SQL

        execute <<-SQL
          UPDATE products
          SET name = 'Facebook brand page',
              short_name = 'Facebook brand page'
          WHERE products.key = 'facebook';
        SQL

        execute <<-SQL
          UPDATE products
          SET name = 'LinkedIn company page',
              short_name = 'LinkedIn company page'
          WHERE products.key = 'linkedin';
        SQL

        dir.down do
        end
      end
    end
  end
end
