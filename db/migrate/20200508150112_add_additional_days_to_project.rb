class AddAdditionalDaysToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :additional_days, :integer, null: false, default: 0
  end
end
