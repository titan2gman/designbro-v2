class ChangeProjectColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :logo_additional_text, :additional_text
  end
end
