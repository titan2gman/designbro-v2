class AddPriceToNda < ActiveRecord::Migration[5.0]
  def change
    add_monetize :ndas, :price
  end
end
