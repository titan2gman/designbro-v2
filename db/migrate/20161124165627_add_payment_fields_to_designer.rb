class AddPaymentFieldsToDesigner < ActiveRecord::Migration[5.0]
  def change
    add_column :designers, :address1, :string
    add_column :designers, :address2, :string
    add_column :designers, :city, :string
    add_column :designers, :state_name, :string
    add_column :designers, :zip, :string
    add_column :designers, :phone, :string
  end
end
