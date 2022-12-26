class AddFinalistToDesigns < ActiveRecord::Migration[5.0]
  def change
    add_column :designs, :finalist, :boolean, null: false, default: false
    add_index :designs, :finalist
  end
end
