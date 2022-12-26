class CreateNdas < ActiveRecord::Migration[5.0]
  def change
    create_table :ndas do |t|
      t.text :value, null: false
      t.references :project, foreign_key: true
      t.boolean :global, index: true, default: false, null: false
    end
  end
end
