class MigrateClientsDataToCompanies < ActiveRecord::Migration[5.2]
  def up
    Client.find_each do |client|
      company = Company.create!(
        company_name: client.company_name,
        address1: client.address1,
        address2: client.address2,
        city: client.city,
        country_code: client.country_code,
        state_name: client.state_name,
        zip: client.zip,
        phone: client.phone,
        vat: client.vat,
        created_at: client.created_at,
        updated_at: client.updated_at
      )

      client.update!(
        company_id: company.id,
        is_owner: true
      )
    end
  end

  def down
  end
end
