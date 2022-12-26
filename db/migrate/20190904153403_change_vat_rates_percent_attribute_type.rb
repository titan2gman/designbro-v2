class ChangeVatRatesPercentAttributeType < ActiveRecord::Migration[5.2]
  def change
    change_column :vat_rates, :percent, :decimal, precision: 5, scale: 2
  end
end
