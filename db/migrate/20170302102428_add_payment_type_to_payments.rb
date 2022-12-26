class AddPaymentTypeToPayments < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :payment_type, :integer
  end
end
