class AddStageTimestampsToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :in_progress_stage_started_at, :datetime
    add_column :projects, :finalist_stage_started_at, :datetime
    add_column :projects, :finalists_selected_stage_started_at, :datetime
    add_column :projects, :review_files_stage_started_at, :datetime
  end
end
