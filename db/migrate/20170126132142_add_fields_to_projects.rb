class AddFieldsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :upgrade_package, :bool, null: false, default: false
    add_column :projects, :business_customer, :bool, null: false, default: false

    add_index :projects, :name
  end
end
