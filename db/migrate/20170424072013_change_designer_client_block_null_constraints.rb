class ChangeDesignerClientBlockNullConstraints < ActiveRecord::Migration[5.0]
  def change
    change_column_null :designer_client_blocks, :client_id,   false
    change_column_null :designer_client_blocks, :designer_id, false

    add_index          :designer_client_blocks, %i(client_id designer_id), unique: true
  end
end
