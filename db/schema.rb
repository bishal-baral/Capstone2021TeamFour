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

ActiveRecord::Schema.define(version: 2021_03_17_222335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "stream_link"
    t.datetime "scheduled_time"
    t.string "title"
    t.string "invitees", default: [], array: true
  end

  create_table "friend_reviews", force: :cascade do |t|
    t.integer "user_id"
    t.integer "review_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "media"
    t.string "content"
    t.integer "user_id"
    t.datetime "post_date"
    t.boolean "recommended"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "join_date"
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.integer "code"
    t.index ["username", "code"], name: "index_users_on_username_and_code", unique: true
  end

end
