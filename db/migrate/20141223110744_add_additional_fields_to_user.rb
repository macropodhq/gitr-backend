class AddAdditionalFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :company, :string
  end
end
