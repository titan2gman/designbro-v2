class CreateProjectStockImages < ActiveRecord::Migration[5.2]
  def change
    create_table :project_stock_images do |t|
      t.string :comment

      t.references :project, foreign_key: true

      t.references :stock_image, foreign_key: { to_table: :uploaded_files }

      t.timestamps
    end

    add_column :projects, :stock_images_exist, :integer, null: false, default: 0
  end
end
