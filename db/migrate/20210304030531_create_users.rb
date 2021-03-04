class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.datetime :join_date
      t.string :username

      t.timestamps
    end
  end
end
