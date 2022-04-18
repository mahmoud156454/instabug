class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :token, null: false, index: { unique: true }
      t.string :name, null: false
      t.bigint :total_chats, default: 0, null: false
      t.timestamps
    end
  end
end
