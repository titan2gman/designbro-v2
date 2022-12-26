class CreateFaqGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :faq_groups do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end
  end
end
