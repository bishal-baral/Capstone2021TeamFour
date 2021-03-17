class RemoveCreateUpdateAts < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :created_at, :string
    remove_column :events, :updated_at, :string
    remove_column :friend_reviews, :created_at, :string
    remove_column :friend_reviews, :updated_at, :string
    remove_column :friends, :created_at, :string
    remove_column :friends, :updated_at, :string
    remove_column :reviews, :created_at, :string
    remove_column :reviews, :updated_at, :string
    remove_column :users, :created_at, :string
    remove_column :users, :updated_at, :string

  end
end
