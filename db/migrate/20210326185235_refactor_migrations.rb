class RefactorMigrations < ActiveRecord::Migration[6.1]
  def change
    create_table 'events', force: :cascade do |t|
      t.integer 'user_id'
      t.datetime 'scheduled_time'
      t.string 'title'
      t.time 'duration'
    end

    create_table 'friendships', force: :cascade do |t|
      t.bigint 'sent_to_id', null: false
      t.bigint 'sent_by_id', null: false
      t.boolean 'status', default: false
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index %w[sent_by_id sent_to_id], name: 'index_friendships_on_sent_by_id_and_sent_to_id', unique: true
      t.index ['sent_by_id'], name: 'index_friendships_on_sent_by_id'
      t.index ['sent_to_id'], name: 'index_friendships_on_sent_to_id'
    end

    create_table 'reviews', force: :cascade do |t|
      t.string 'media'
      t.string 'content'
      t.integer 'user_id'
      t.datetime 'post_date'
      t.boolean 'recommended'
    end

    create_table 'users', force: :cascade do |t|
      t.datetime 'join_date'
      t.string 'username'
      t.string 'password_digest'
      t.string 'email'
      t.integer 'code'
      t.index %w[username code], name: 'index_users_on_username_and_code', unique: true
    end

    add_foreign_key 'friendships', 'users', column: 'sent_by_id'
    add_foreign_key 'friendships', 'users', column: 'sent_to_id'
    add_index :friendships, %i[sent_by_id sent_to_id], unique: true
  end
end
