# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150617010046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abouts", force: :cascade do |t|
    t.string   "title"
    t.text     "about_desc"
    t.string   "about_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bam_users", force: :cascade do |t|
    t.integer  "user_bam"
    t.integer  "user_id"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friend_invites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "invite_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "friends", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "user_avatar"
    t.string   "friend_avatar"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_channels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "send_by"
    t.integer  "message_channel_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "read"
    t.string   "msg"
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "img_url"
    t.text     "news_text"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_invites", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.string   "invite_token"
    t.integer  "sent_by"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "permission_id"
    t.date     "since"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "team_permissions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "tag"
    t.string   "website"
    t.string   "password"
    t.string   "about"
    t.integer  "game_id"
    t.string   "img_logo"
    t.string   "img_cover"
    t.string   "token_confirmation"
    t.boolean  "active"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "acc_fb"
    t.string   "acc_twitter"
    t.string   "acc_ig"
    t.string   "acc_tube"
    t.string   "acc_twitch"
    t.string   "acc_steam"
  end

  create_table "user_transations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "type"
    t.float    "price"
    t.string   "local"
    t.string   "key1"
    t.string   "key2"
    t.string   "status"
    t.boolean  "confirmed"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "country"
    t.string   "email"
    t.date     "birthdate"
    t.string   "primary_game"
    t.string   "nick_name"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "img_avatar"
    t.date     "last_login"
    t.integer  "login_count"
    t.integer  "age"
    t.string   "my_resume"
    t.string   "titles"
    t.string   "token_confirmation"
    t.boolean  "active"
    t.string   "token_reset_confirmation"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "app_access_token"
    t.string   "acc_fb"
    t.string   "acc_twitter"
    t.string   "acc_ig"
    t.string   "acc_tube"
    t.string   "acc_twitch"
    t.string   "acc_steam"
  end

  create_table "welcome_banners", force: :cascade do |t|
    t.string   "name"
    t.string   "img_url"
    t.integer  "game_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "welcome_videos", force: :cascade do |t|
    t.string   "name"
    t.string   "link"
    t.string   "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
