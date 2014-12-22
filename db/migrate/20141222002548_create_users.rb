class CreateUsers < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :users, id: :uuid do |t|
      t.string :login, index: true
      t.integer :github_id, index: true
      t.string :avatar_url
      t.integer :public_repos
      t.integer :public_gists
      t.integer :followers
      t.integer :following
      t.string :location
      t.string :name

      t.timestamps null: false
    end
  end
end
