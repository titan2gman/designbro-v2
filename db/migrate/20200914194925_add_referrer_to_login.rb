class AddReferrerToLogin < ActiveRecord::Migration[5.2]
  def change
    add_column :logins, :origin_2, :string
  end
end
