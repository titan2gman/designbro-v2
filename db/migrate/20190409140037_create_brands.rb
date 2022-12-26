class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :slogan
      t.text :additional_text
      t.text :description
      t.text :background_story
      t.text :where_it_is_used
      t.text :what_is_special
      t.references :company, index: true, foreign_key: true

      t.timestamps
    end
  end
end
