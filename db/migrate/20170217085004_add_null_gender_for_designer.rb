class AddNullGenderForDesigner < ActiveRecord::Migration[5.0]
  def change
    change_column_null :designers, :gender, true
  end
end
