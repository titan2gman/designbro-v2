class AddNameToDesigns < ActiveRecord::Migration[5.0]
  def change
    add_column :designs, :name, :string
  end
end
