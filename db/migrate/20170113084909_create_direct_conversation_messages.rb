class CreateDirectConversationMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :direct_conversation_messages do |t|
      t.references :user, foreign_key: true
      t.references :design, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
