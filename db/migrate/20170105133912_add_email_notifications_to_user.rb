class AddEmailNotificationsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notify_projects_updates, :boolean
    add_column :users, :notify_messages_received, :boolean
    add_column :users, :notify_news, :boolean
    add_column :users, :inform_on_email, :string
  end
end
