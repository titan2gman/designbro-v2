class CreateStartNotificationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :start_notification_requests do |t|
      t.string :email, null: false, index: true
      t.timestamps
    end
  end
end
