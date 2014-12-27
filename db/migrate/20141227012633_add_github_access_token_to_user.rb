class AddGithubAccessTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_access_token, :string
  end
end
