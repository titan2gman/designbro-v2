class ChangeDefaultForOneToOneAvailable < ActiveRecord::Migration[5.2]
  def change
    change_column_default :designers, :one_to_one_available, from: false, to: true
  end
end
