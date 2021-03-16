class AddFriendCodeUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :code, :integer
  end
end
