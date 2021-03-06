class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :media
      t.string :content
      t.integer :user_id
      t.datetime :post_date

      t.timestamps
    end
  end
end
