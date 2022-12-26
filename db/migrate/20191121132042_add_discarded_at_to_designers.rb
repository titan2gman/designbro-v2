class AddDiscardedAtToDesigners < ActiveRecord::Migration[5.2]
  def change
    add_column :designers, :discarded_at, :datetime
    add_index :designers, :discarded_at
  end
end
