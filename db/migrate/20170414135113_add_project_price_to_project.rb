class AddProjectPriceToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :normalized_type_price, :integer

    Project.all.each do |project|
      project.update(normalized_type_price: ProjectPrice.find_by(project_type: project.project_type).normalized_price)
    end
  end
end
