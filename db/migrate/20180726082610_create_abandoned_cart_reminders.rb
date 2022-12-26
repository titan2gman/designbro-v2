class CreateAbandonedCartReminders < ActiveRecord::Migration[5.1]
  def change
    create_table :abandoned_cart_reminders do |t|
      t.string  :name
      t.integer :step
      t.integer :minutes_to_reminder

      t.timestamps
    end
  end
end
