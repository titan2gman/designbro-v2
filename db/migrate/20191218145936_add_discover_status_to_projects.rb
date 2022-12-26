class AddDiscoverStatusToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :discoverable,:boolean, null: false, default: true
  end
end
