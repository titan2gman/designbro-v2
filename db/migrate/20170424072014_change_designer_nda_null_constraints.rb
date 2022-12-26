class ChangeDesignerNdaNullConstraints < ActiveRecord::Migration[5.0]
  def change
    change_column_null :designer_ndas, :nda_id,      false
    change_column_null :designer_ndas, :designer_id, false

    remove_columns     :designer_ndas, :project_id

    add_index          :designer_ndas, %i[designer_id nda_id], unique: true
  end
end
