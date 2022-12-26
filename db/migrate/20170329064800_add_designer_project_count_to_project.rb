class AddDesignerProjectCountToProject < ActiveRecord::Migration[5.0]
  def self.up
    add_column :projects, :designer_projects_count, :integer, default: 0

    Project.reset_column_information
    Project.all.each do |p|
      Project.update_counters p.id, designer_projects_count: p.designer_projects.length
    end
  end

  def self.down
    remove_column :projects, :designer_projects_count
  end
end
