class RemoveStreamLinkFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :stream_link, :string
  end
end
