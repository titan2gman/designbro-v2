class AddClientRefToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :client, foreign_key: true
  end
end
