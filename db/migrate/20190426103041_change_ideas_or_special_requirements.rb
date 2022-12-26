class ChangeIdeasOrSpecialRequirements < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :ideas_or_special_requirements, :text
    change_column_null :projects, :ideas_or_special_requirements, true
    change_column_default :projects, :ideas_or_special_requirements, nil
  end
end
