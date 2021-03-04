class CreateFriendReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_reviews do |t|
      t.integer :friend_review_id
      t.integer :user_id
      t.integer :review_id

      t.timestamps
    end
  end
end
