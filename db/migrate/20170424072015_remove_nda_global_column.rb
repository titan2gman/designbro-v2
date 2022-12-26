class RemoveNdaGlobalColumn < ActiveRecord::Migration[5.0]
  def change
    remove_columns :ndas, :global
  end
end
