class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.bigint :total_messages, default: 0, null: false
      t.bigint :chat_number, default: 0, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
