class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches, id: :uuid do |t|
      t.uuid :user_id, index: true
      t.uuid :other_user_id, index: true
      t.boolean :match, index: true

      t.timestamps null: false
    end

    add_foreign_key :matches, :users
    add_foreign_key :matches, :users, column: :other_user_id
  end
end
