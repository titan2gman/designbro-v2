class AddMandatorySteps < ActiveRecord::Migration[5.2]
  def change
    rename_column :project_builder_steps, :mandatory, :mandatory_for_one_to_one_project

    add_column :project_builder_steps, :mandatory_for_existing_brand, :boolean, null: false, default: false
  end
end
