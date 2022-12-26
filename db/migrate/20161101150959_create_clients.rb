class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.text :address1
      t.text :address2
      t.string :city
      t.string :country
      t.string :state_name
      t.string :zip
      t.string :phone
      t.string :vat
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
