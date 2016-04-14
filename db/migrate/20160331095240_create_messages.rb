class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :chat_id
      t.integer :sender_id
      t.text :content
      t.timestamps null: false
    end
  end
end
