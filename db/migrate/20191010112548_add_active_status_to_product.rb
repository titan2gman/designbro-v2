class AddActiveStatusToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :active, :boolean, default: true
  end
end
