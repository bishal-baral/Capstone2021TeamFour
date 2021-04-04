class RemoveInviteesFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :invitees, :string
  end
end
