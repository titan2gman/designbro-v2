class UpdateStandardNdaPrice < ActiveRecord::Migration[5.2]
  def up
    NdaPrice.standard.first.update(
      price: 35
    )
  end

  def down
  end
end
