class RemoveRedundantClientColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :company_name, :string
    remove_column :clients, :address1, :text
    remove_column :clients, :address2, :text
    remove_column :clients, :city, :string
    remove_column :clients, :country_code, :string
    remove_column :clients, :state_name, :string
    remove_column :clients, :zip, :string
    remove_column :clients, :phone, :string
    remove_column :clients, :vat, :string

    drop_table :billing_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :country_code
      t.string :company
      t.string :vat
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.references :project, index: true, foreign_key: true
    end
  end
end
