class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.integer :friend_id
      t.integer :user_one
      t.integer :user_two

      t.timestamps
    end
  end
end
