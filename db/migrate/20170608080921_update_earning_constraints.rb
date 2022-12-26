class UpdateEarningConstraints < ActiveRecord::Migration[5.0]
  def change
    change_column_null :earnings, :project_id, false
    change_column_null :earnings, :designer_id, false
  end
end
