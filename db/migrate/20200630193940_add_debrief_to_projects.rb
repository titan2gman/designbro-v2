class AddDebriefToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :debrief, :text
  end
end
