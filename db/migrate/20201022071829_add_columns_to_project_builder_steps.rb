class AddColumnsToProjectBuilderSteps < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :layout_version, :integer, null: false, default: 1

    add_column :project_builder_steps, :component_name, :string
  end
end
