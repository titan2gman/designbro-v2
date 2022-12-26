class DeleteAmountAndClientFromPayments < ActiveRecord::Migration[5.0]
  def change
    remove_column :payments, :amount
    remove_column :payments, :client_id
  end
end
