class CreateDatabaseDumps < ActiveRecord::Migration[5.1]
  def change
    create_table :database_dumps do |t|
      t.string :file
      t.string :original_filename
      t.timestamps
    end
  end
end
