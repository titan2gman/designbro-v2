class AddPriceToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :price, :integer
  end
end
