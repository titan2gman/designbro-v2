class AddUnreadStateToDesign < ActiveRecord::Migration[5.2]
  def change
    add_column :designs, :unread, :boolean, default: true, null: false

    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE designs
          SET unread = false
        SQL
      end

      dir.down do
      end
    end
  end
end
