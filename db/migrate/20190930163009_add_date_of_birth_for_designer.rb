class AddDateOfBirthForDesigner < ActiveRecord::Migration[5.2]
  def change
    add_column :designers, :date_of_birth, :date
  end
end
