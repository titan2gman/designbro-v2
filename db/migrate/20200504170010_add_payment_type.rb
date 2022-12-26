class AddPaymentType < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :paid_for, :integer, null: false, default: 0
  end
end
