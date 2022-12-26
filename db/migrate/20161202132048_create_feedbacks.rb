class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :name, null: false
      t.string :email, null: false, index: true
      t.string :subject, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
