class RenameCountryToCountryCodeForDesigner < ActiveRecord::Migration[5.0]
  def change
    rename_column :designers, :country, :country_code
  end
end
