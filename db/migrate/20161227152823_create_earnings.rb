class CreateEarnings < ActiveRecord::Migration[5.0]
  def change
    create_table :earnings do |t|
      t.references :designer
      t.references :project
      t.string :state
      t.integer :amount, default: 0
      t.timestamps
    end
    add_index :earnings, :state
  end
end
