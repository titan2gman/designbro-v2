class CreatePlasticPackPackagingMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :plastic_pack_packaging_measurements do |t|
      t.references :technical_drawing,
                   foreign_key: { to_table: :uploaded_files },
                   index: { name: 'index_technical_drawing_id' }

      t.timestamps
    end
  end
end
