class AddMaxSpotsCountToDesigner < ActiveRecord::Migration[5.2]
  def change
    add_column :designers, :max_active_spots_count, :integer
  end
end
