class CreatePortfolioImages < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolio_images do |t|
      t.belongs_to :uploaded_file, null: false

      t.timestamps
    end
  end
end
