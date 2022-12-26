class AddNullAndDefaultConstraintsToProjects < ActiveRecord::Migration[5.0]
  def change
    options = { null: false, default: '' }

    change_column :projects, :slogan, :string, options
    change_column :projects, :brand_name, :string, options
    change_column :projects, :company_description, :string, options
    change_column :projects, :logo_additional_text, :string, options
  end
end
