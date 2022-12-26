class RenamePackagingMeasurementsColumns < ActiveRecord::Migration[5.0]
  def change
    change_column :bottle_packaging_measurements, :label_width, :string
    change_column :bottle_packaging_measurements, :label_height, :string

    change_column :can_packaging_measurements, :height, :string
    change_column :can_packaging_measurements, :volume, :string
    change_column :can_packaging_measurements, :diameter, :string

    change_column :card_box_packaging_measurements, :front_height, :string
    change_column :card_box_packaging_measurements, :front_width, :string
    change_column :card_box_packaging_measurements, :side_depth, :string

    change_column :label_packaging_measurements, :label_width, :string
    change_column :label_packaging_measurements, :label_height, :string

    change_column :pouch_packaging_measurements, :width, :string
    change_column :pouch_packaging_measurements, :height, :string
  end
end
