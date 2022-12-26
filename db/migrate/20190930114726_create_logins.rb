class CreateLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :logins do |t|
      t.references :user, foreign_key: true
      t.string :ip
      t.string :origin

      t.timestamps
    end
  end
end
