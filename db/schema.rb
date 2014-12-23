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

ActiveRecord::Schema.define(version: 20141223002221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "matches", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "other_user_id"
    t.boolean  "match"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "matches", ["match"], name: "index_matches_on_match", using: :btree
  add_index "matches", ["other_user_id"], name: "index_matches_on_other_user_id", using: :btree
  add_index "matches", ["user_id"], name: "index_matches_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.uuid     "user_id"
    t.uuid     "other_user_id"
    t.text     "text"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "messages", ["other_user_id"], name: "index_messages_on_other_user_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "login"
    t.integer  "github_id"
    t.string   "avatar_url"
    t.integer  "public_repos"
    t.integer  "public_gists"
    t.integer  "followers"
    t.integer  "following"
    t.string   "location"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "users", ["github_id"], name: "index_users_on_github_id", using: :btree
  add_index "users", ["login"], name: "index_users_on_login", using: :btree

  add_foreign_key "matches", "users"
  add_foreign_key "matches", "users", column: "other_user_id"
  add_foreign_key "messages", "users"
  add_foreign_key "messages", "users", column: "other_user_id"
end
