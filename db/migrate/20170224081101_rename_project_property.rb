class RenameProjectProperty < ActiveRecord::Migration[5.0]
  def change
    change_table :projects do |t|
      t.rename :price, :normalized_price
    end
  end
end
