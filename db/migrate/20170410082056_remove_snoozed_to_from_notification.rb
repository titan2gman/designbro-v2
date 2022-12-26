class RemoveSnoozedToFromNotification < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :snoozed_to
    remove_column :notifications, :closed
    add_column :notifications, :closed, :boolean, default: false
  end
end
