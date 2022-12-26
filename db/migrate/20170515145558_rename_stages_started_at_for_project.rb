class RenameStagesStartedAtForProject < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :projects, :in_progress_stage_started_at, :design_stage_started_at
    rename_column :projects, :winner_selected_stage_started_at, :files_stage_started_at

    remove_column :projects, :finalists_selected_stage_started_at

    Project.design_stage.each do |project|
      project.update(design_stage_started_at: Time.zone.now)
    end

    Project.files_stage.each do |project|
      project.update(files_stage_started_at: Time.zone.now)
    end
  end

  def self.down
    rename_column :projects, :design_stage_started_at, :in_progress_stage_started_at
    rename_column :projects, :files_stage_started_at, :winner_selected_stage_started_at

    add_column :projects, :finalists_selected_stage_started_at, :datetime
  end
end
