class DeleteNullConstraintsForNdas < ActiveRecord::Migration[5.0]
  def change
    change_column_null :ndas, :value, true
    change_column_null :ndas, :project_id, false
  end
end
