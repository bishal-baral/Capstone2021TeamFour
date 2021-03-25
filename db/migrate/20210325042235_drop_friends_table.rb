class DropFriendsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :friends
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
