class AddDesignToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :design, foreign_key: true
  end
end
