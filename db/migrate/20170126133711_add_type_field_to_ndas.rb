class AddTypeFieldToNdas < ActiveRecord::Migration[5.0]
  def change
    add_column :ndas, :nda_type, :integer, default: 0, null: false

    add_index :ndas, :nda_type
  end
end
