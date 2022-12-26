class CreateFaqItems < ActiveRecord::Migration[5.0]
  def change
    create_table :faq_items do |t|
      t.string :name, null: false, index: true
      t.text :answer, null: false

      t.references :faq_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
