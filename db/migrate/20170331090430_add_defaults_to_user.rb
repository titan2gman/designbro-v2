class AddDefaultsToUser < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :notify_news, :boolean, default: true
    change_column :users, :notify_messages_received, :boolean, default: true
    change_column :users, :notify_projects_updates, :boolean, default: true
  end

  def self.down
    change_column :users, :notify_news, :boolean, default: nil
    change_column :users, :notify_messages_received, :boolean, default: nil
    change_column :users, :notify_projects_updates, :boolean, default: nil
  end
end
