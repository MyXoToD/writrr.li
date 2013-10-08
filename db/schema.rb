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

ActiveRecord::Schema.define(version: 20131008121030) do

  create_table "chapters", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "stories_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chapters", ["stories_id"], name: "index_chapters_on_stories_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "value"
    t.integer  "users_id"
    t.integer  "chapters_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["chapters_id"], name: "index_ratings_on_chapters_id", using: :btree
  add_index "ratings", ["users_id"], name: "index_ratings_on_users_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "stories", force: true do |t|
    t.string   "title"
    t.text     "teaser"
    t.string   "genre"
    t.integer  "users_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["users_id"], name: "index_stories_on_users_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "name"
    t.string   "image"
    t.string   "link"
    t.string   "location"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
