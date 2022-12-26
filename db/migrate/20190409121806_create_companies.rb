class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.text   :address1
      t.text   :address2
      t.string :city
      t.string :country_code
      t.string :state_name
      t.string :zip
      t.string :phone
      t.string :vat

      t.timestamps
    end

    add_reference :clients, :company, index: true, foreign_key: true
    add_column :clients, :is_owner, :boolean, null: false, default: false
    add_column :clients, :preferred_payment_method, :payment_method
  end
end
