class AddStateToDesigns < ActiveRecord::Migration[5.0]
  def change
    add_column :designs, :state, :string
    add_index :designs, :state
    remove_column :designs, :finalist
  end
end
