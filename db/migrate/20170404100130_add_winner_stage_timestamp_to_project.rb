class AddWinnerStageTimestampToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :winner_selected_stage_started_at, :datetime
  end
end
