class DeleteAddress2NullConstraint < ActiveRecord::Migration[5.0]
  def change
    change_column_null :billing_addresses, :address2, true
  end
end
