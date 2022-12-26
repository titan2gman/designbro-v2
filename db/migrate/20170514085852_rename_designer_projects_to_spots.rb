class RenameDesignerProjectsToSpots < ActiveRecord::Migration[5.0]
  def change
    rename_table  :designer_projects, :spots

    change_column_null :spots, :designer_id, false
    change_column_null :spots, :project_id,  false

    rename_column :designs,  :designer_project_id,     :spot_id
    rename_column :projects, :designer_projects_count, :spots_count

    change_column_null :designs, :name,             false
    change_column_null :designs, :rating,           false
    change_column_null :designs, :spot_id,          false
    change_column_null :designs, :uploaded_file_id, false

    add_foreign_key :designs, :uploaded_files

    remove_column :designs, :state
    remove_column :designs, :project_id
    remove_column :designs, :designer_id

    PaperTrail::Version.where(item_type: 'Design', event: 'create').destroy_all
  end
end
