class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.bigint :message_number, default: 0, null: false, index: { unique: true }
      t.string :content, null: false
      t.timestamps
    end
  end
end
