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

ActiveRecord::Schema.define(version: 20150413023863) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "arcadex_tokens", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_ip_address"
    t.string   "current_ip_address"
    t.integer  "times_used"
    t.integer  "expiration_minutes"
    t.integer  "max_uses"
  end

  add_index "arcadex_tokens", ["auth_token"], name: "index_arcadex_tokens_on_auth_token", unique: true

  create_table "defcon_admin_users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.boolean  "read_only"
    t.integer  "attempts"
    t.integer  "max_attempts"
    t.boolean  "master"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_index "defcon_admin_users", ["email"], name: "index_defcon_admin_users_on_email", unique: true
  add_index "defcon_admin_users", ["username"], name: "index_defcon_admin_users_on_username", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "fb_user_id"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["fb_user_id"], name: "index_users_on_fb_user_id", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
