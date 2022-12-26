class ChangeProjectsBusinessCustomerDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :projects, :business_customer, true
  end
end
