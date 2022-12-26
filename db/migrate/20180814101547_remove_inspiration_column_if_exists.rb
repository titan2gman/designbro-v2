class RemoveInspirationColumnIfExists < ActiveRecord::Migration[5.1]
  def change
    return unless column_exists?(:projects, :inspiration, :string)
    remove_column :projects, :inspiration
  end
end
