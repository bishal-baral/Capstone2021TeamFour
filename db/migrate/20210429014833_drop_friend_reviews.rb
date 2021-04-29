class DropFriendReviews < ActiveRecord::Migration[6.1]
  def up
    drop_table :friend_reviews
  end
end
