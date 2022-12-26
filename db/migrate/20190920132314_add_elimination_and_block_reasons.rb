class AddEliminationAndBlockReasons < ActiveRecord::Migration[5.2]
  def change
    add_column :designs, :eliminate_reason, :integer, index: true
    add_column :designs, :eliminate_custom_reason, :string
    add_column :designer_client_blocks, :block_reason, :integer, index: true
    add_column :designer_client_blocks, :block_custom_reason, :string
  end
end
