class RenameIsPaidColumnInNda < ActiveRecord::Migration[5.2]
  def change
    rename_column :ndas, :is_paid, :paid
  end
end
