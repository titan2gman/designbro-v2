class AddHiddenToBrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :visible, :boolean, null: false, default: true
  end
end
