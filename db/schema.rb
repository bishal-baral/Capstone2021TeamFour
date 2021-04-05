# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_04_184725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "stream_link"
    t.datetime "scheduled_time"
    t.string "title"
  end

  create_table "friend_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "sent_to_id", null: false
    t.bigint "sent_by_id", null: false
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sent_by_id", "sent_to_id"], name: "index_friendships_on_sent_by_id_and_sent_to_id", unique: true
    t.index ["sent_by_id"], name: "index_friendships_on_sent_by_id"
    t.index ["sent_to_id"], name: "index_friendships_on_sent_to_id"
  end

  create_table "invitees", force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  create_table "review_tags", force: :cascade do |t|
    t.integer "review_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "media"
    t.string "content"
    t.integer "user_id"
    t.datetime "post_date"
    t.boolean "recommended"
  end

  create_table "tags", force: :cascade do |t|
    t.string "category"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category", "name"], name: "index_tags_on_category_and_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "join_date"
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.integer "code"
    t.index ["username", "code"], name: "index_users_on_username_and_code", unique: true
  end

  add_foreign_key "friendships", "users", column: "sent_by_id"
  add_foreign_key "friendships", "users", column: "sent_to_id"
end
