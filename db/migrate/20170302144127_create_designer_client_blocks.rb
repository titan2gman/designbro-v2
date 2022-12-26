class CreateDesignerClientBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :designer_client_blocks, id: false do |t|
      t.references :designer
      t.references :client

      t.timestamps
    end
  end
end
