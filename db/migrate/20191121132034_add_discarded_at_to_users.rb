class AddDiscardedAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :discarded_at, :datetime
    add_index :users, :discarded_at
  end
end
