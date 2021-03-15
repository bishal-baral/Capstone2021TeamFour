class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :stream_link
      t.datetime :scheduled_time
      t.string :title
      t.string :invitees, array: true, default: []

      t.timestamps
    end
  end
end
