class CreatePortfolioWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolio_works do |t|
      t.text :description
      t.integer :work_type, null: false
      t.references :designer, foreign_key: true
    end
  end
end
