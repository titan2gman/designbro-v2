class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :client
      t.references :project
      t.string :payment_id
      t.integer :amount, default: 0
      t.timestamps
    end
  end
end
