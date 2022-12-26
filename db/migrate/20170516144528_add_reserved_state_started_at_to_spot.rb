class AddReservedStateStartedAtToSpot < ActiveRecord::Migration[5.0]
  def change
    add_column :spots, :reserved_state_started_at, :datetime
  end
end
