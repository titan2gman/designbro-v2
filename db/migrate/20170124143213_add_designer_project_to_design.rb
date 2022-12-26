class AddDesignerProjectToDesign < ActiveRecord::Migration[5.0]
  def change
    add_reference :designs, :designer_project, foreign_key: true
  end
end
