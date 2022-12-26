class AddDescriptionToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :description, :string
  end
end
