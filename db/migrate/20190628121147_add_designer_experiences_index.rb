class AddDesignerExperiencesIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :designer_experiences, [:designer_id, :product_category_id], unique: true, name: 'index_designer_experiences_on_designer_and_product_category'
  end
end
