class CreateCanPackagingMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :can_packaging_measurements do |t|
      t.decimal :height
      t.decimal :volume
      t.decimal :diameter

      t.references :technical_drawing, foreign_key: { to_table: :uploaded_files }

      t.timestamps
    end
  end
end
