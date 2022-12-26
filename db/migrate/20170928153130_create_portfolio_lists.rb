class CreatePortfolioLists < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolio_lists do |t|
      t.string :list_type, null: false

      t.timestamps
    end
  end
end
