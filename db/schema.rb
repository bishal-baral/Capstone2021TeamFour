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

ActiveRecord::Schema.define(version: 2021_04_23_182752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "scheduled_time"
    t.string "title"
    t.time "duration"
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
    t.bigint "user_id"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_invitees_on_event_id"
    t.index ["user_id"], name: "index_invitees_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "review_tags", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "review_id"
    t.index ["review_id"], name: "index_review_tags_on_review_id"
    t.index ["tag_id"], name: "index_review_tags_on_tag_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "media"
    t.string "content"
    t.integer "user_id"
    t.datetime "post_date"
    t.boolean "recommended"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.boolean "expired", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "category"
    t.string "name"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "friendships", "users", column: "sent_by_id"
  add_foreign_key "friendships", "users", column: "sent_to_id"
end
