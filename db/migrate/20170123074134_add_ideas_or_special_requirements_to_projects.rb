class AddIdeasOrSpecialRequirementsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :ideas_or_special_requirements, :string, null: false, default: ''
  end
end
