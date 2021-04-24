class AddDurationToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :duration, :time
  end
end
