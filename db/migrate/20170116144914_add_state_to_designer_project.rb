class AddStateToDesignerProject < ActiveRecord::Migration[5.0]
  def change
    add_column :designer_projects, :state, :string, index: true
  end
end
