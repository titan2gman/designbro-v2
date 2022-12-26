class AddGodToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :god, :boolean, null: false, default: false
  end
end
