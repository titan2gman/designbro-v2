class AddLastSeenAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_seen_at, :timestamp
  end
end
