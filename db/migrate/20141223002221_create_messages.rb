class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.uuid :user_id, index: true
      t.uuid :other_user_id, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :messages, :users
    add_foreign_key :messages, :users, column: :other_user_id
  end
end
