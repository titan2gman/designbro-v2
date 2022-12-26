class AddOneToOneAllowedToDesigners < ActiveRecord::Migration[5.2]
  def change
    add_column :designers, :one_to_one_allowed, :boolean, null: false, default: false
  end
end
