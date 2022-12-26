class CreateUploadedFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :uploaded_files do |t|
      t.references :entity, polymorphic: true
      t.string :file
      t.string :type, null: false
      t.string :original_filename

      t.timestamps
    end
  end
end
