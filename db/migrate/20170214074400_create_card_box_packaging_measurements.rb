class CreateCardBoxPackagingMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :card_box_packaging_measurements do |t|
      t.decimal :side_depth
      t.decimal :front_width
      t.decimal :front_height

      t.references :technical_drawing, foreign_key: { to_table: :uploaded_files }

      t.timestamps
    end
  end
end
