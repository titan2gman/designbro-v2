class AddCreditCardInfoToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :payment_method_id, :string
    add_column :clients, :credit_card_number, :string
    add_column :clients, :credit_card_provider, :string
  end
end
