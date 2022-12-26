class CreatePouchPackagingMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :pouch_packaging_measurements do |t|
      t.decimal :width
      t.decimal :height

      t.references :technical_drawing, foreign_key: { to_table: :uploaded_files }

      t.timestamps
    end
  end
end
