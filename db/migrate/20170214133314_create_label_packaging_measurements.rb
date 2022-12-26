class CreateLabelPackagingMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :label_packaging_measurements do |t|
      t.decimal :label_width
      t.decimal :label_height

      t.references :technical_drawing, foreign_key: { to_table: :uploaded_files }

      t.timestamps
    end
  end
end
