class AddBriefFieldToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :brand_name, :string
    add_column :projects, :slogan, :string
    add_column :projects, :logo_additional_text, :string
    add_column :projects, :company_description, :string
  end
end
