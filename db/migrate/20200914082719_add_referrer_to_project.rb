class AddReferrerToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :referrer, :string
  end
end
