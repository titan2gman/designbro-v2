class RenameCountryToCountryCodeForClients < ActiveRecord::Migration[5.1]
  def change
    rename_column :clients, :country, :country_code

    Client.where.not(country_code: nil).each do |client|
      client.country_code = ISO3166::Country.find_country_by_name(client.country_code)&.alpha2
      client.save(validate: false)
    end
  end
end
