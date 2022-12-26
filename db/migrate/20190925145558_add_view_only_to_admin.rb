class AddViewOnlyToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :view_only, :boolean
  end
end
