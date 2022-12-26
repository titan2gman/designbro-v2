class AddMeasurementsRefToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :packaging_measurements, polymorphic: true, index: { name: 'packaging_measurements_index' }
  end
end
