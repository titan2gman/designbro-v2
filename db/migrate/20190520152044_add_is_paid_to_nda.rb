class AddIsPaidToNda < ActiveRecord::Migration[5.2]
  def change
    add_column :ndas, :is_paid, :boolean, null: false, default: false
  end
end
