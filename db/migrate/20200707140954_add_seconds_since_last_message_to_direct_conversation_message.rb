class AddSecondsSinceLastMessageToDirectConversationMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :direct_conversation_messages, :seconds_since_last_message, :integer
    add_column :designers, :average_response_time, :integer
  end
end
