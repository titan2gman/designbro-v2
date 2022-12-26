class AddOptOutColumnToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :opt_out, :boolean, null: false, default: false
  end
end
