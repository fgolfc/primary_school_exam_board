# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_04_025333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "response_id"
    t.integer "post_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "comment"
    t.index ["post_id"], name: "index_notifications_on_post_id"
    t.index ["response_id"], name: "index_notifications_on_response_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_likes_on_post_id"
    t.index ["user_id"], name: "index_post_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", default: 1, null: false
    t.integer "post_likes_count", default: 0, null: false
    t.integer "responses_count"
    t.integer "responses_likes_count"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "response_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "response_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["response_id"], name: "index_response_likes_on_response_id"
    t.index ["user_id"], name: "index_response_likes_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.text "body"
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.integer "response_likes_count", default: 0
    t.index ["post_id"], name: "index_responses_on_post_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname", null: false
    t.integer "prefecture", null: false
    t.boolean "admin", default: false
    t.string "unconfirmed_email"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "post_likes", "posts"
  add_foreign_key "post_likes", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "response_likes", "responses"
  add_foreign_key "response_likes", "users"
  add_foreign_key "responses", "posts"
  add_foreign_key "responses", "users"
end
