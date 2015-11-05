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

ActiveRecord::Schema.define(version: 20151103191148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adverts", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "adverts", ["user_id"], name: "index_adverts_on_user_id", using: :btree

  create_table "favourite_adverts", id: false, force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "advert_id", null: false
  end

  add_index "favourite_adverts", ["advert_id"], name: "index_favourite_adverts_on_advert_id", using: :btree
  add_index "favourite_adverts", ["user_id"], name: "index_favourite_adverts_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "from_id",    null: false
    t.integer  "to_id",      null: false
    t.string   "topic",      null: false
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["from_id"], name: "index_messages_on_from_id", using: :btree
  add_index "messages", ["to_id"], name: "index_messages_on_to_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "name",            null: false
    t.string   "surname",         null: false
    t.string   "email",           null: false
    t.string   "phone",           null: false
    t.integer  "role",            null: false
    t.integer  "gender",          null: false
    t.boolean  "verified",        null: false
    t.boolean  "bulletin",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["username", "email"], name: "index_users_on_username_and_email", unique: true, using: :btree

  create_table "viewed_adverts", id: false, force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "advert_id", null: false
  end

  add_index "viewed_adverts", ["advert_id"], name: "index_viewed_adverts_on_advert_id", using: :btree
  add_index "viewed_adverts", ["user_id"], name: "index_viewed_adverts_on_user_id", using: :btree

  add_foreign_key "adverts", "users", on_delete: :cascade
end
