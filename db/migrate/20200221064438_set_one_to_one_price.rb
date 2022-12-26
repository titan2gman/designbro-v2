class SetOneToOnePrice < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      UPDATE products
      SET one_to_one_price_cents = price_cents
    SQL
  end

  def down
  end
end
