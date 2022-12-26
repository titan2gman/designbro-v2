class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :message, null: false
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.string :type, index: true
      t.integer :priority, default: 0, null: false
      t.integer :closed, default: 0, null: false
      t.timestamp :snoozed_to

      t.timestamps
    end
  end
end
