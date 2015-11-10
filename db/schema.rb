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

ActiveRecord::Schema.define(version: 20151109221320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adverts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "advertable_id"
    t.string   "advertable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "adverts", ["advertable_type", "advertable_id"], name: "index_adverts_on_advertable_type_and_advertable_id", using: :btree
  add_index "adverts", ["user_id"], name: "index_adverts_on_user_id", using: :btree

  create_table "favourite_adverts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "advert_id"
  end

  add_index "favourite_adverts", ["advert_id"], name: "index_favourite_adverts_on_advert_id", using: :btree
  add_index "favourite_adverts", ["user_id"], name: "index_favourite_adverts_on_user_id", using: :btree

  create_table "homemates", force: :cascade do |t|
  end

  create_table "images", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "imagefile_file_name"
    t.string   "imagefile_content_type"
    t.integer  "imagefile_file_size"
    t.datetime "imagefile_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "images", ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree

  create_table "lessonnotes", force: :cascade do |t|
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.string   "topic"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["from_id"], name: "index_messages_on_from_id", using: :btree
  add_index "messages", ["to_id"], name: "index_messages_on_to_id", using: :btree

  create_table "privatelessons", force: :cascade do |t|
  end

  create_table "secondhands", force: :cascade do |t|
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
  end

  add_index "universities", ["name"], name: "index_universities_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "phone"
    t.integer  "role"
    t.integer  "gender"
    t.boolean  "verified"
    t.boolean  "bulletin"
    t.date     "birthday"
    t.text     "address"
    t.integer  "university_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  create_table "viewed_advert_counts", force: :cascade do |t|
    t.integer "advert_id"
    t.string  "ip"
  end

  create_table "viewed_adverts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "advert_id"
  end

  add_index "viewed_adverts", ["advert_id"], name: "index_viewed_adverts_on_advert_id", using: :btree
  add_index "viewed_adverts", ["user_id"], name: "index_viewed_adverts_on_user_id", using: :btree

end
