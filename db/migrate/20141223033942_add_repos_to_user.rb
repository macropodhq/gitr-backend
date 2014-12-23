class AddReposToUser < ActiveRecord::Migration
  def change
    add_column :users, :repos, :json
  end
end
