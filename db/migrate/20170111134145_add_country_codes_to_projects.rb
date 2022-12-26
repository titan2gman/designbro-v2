class AddCountryCodesToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :target_country_codes, :string, array: true, default: []
  end
end
