class AddDesignerColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :designers, :description, :text
    add_column :designers, :languages, :jsonb
    add_column :designers, :visible, :boolean, null: false, default: false
    add_column :designers, :badge, :string

    add_column :projects, :visible, :boolean, null: false, default: false
  end
end
