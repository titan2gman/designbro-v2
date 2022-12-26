class AddFieldsToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :background_story, :string
    add_column :projects, :where_it_is_used, :string
    add_column :projects, :what_is_special, :string
    add_column :projects, :what_to_design, :string
    add_column :projects, :design_type, :integer
  end
end
