class DeleteNullConstraintsForPayment < ActiveRecord::Migration[5.0]
  def change
    change_column_null :payments, :client_id, false
    change_column_null :payments, :project_id, false
    change_column_null :payments, :payment_id, false
  end
end
