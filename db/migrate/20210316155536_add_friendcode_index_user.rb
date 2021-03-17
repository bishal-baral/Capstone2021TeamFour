class AddFriendcodeIndexUser < ActiveRecord::Migration[6.1]
  def change
    add_index :users, [:username, :code], unique: true
  end
end
