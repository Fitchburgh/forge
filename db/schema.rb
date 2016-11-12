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

ActiveRecord::Schema.define(version: 20161112182852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "backgrounds", force: :cascade do |t|
    t.json     "obj"
    t.integer  "user_id"
    t.integer  "shard_id"
    t.boolean  "public"
    t.json     "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shard_id"], name: "index_backgrounds_on_shard_id", using: :btree
    t.index ["user_id"], name: "index_backgrounds_on_user_id", using: :btree
  end

  create_table "collaborators", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_collaborators_on_game_id", using: :btree
    t.index ["user_id"], name: "index_collaborators_on_user_id", using: :btree
  end

  create_table "entities", force: :cascade do |t|
    t.json     "obj"
    t.integer  "user_id"
    t.integer  "shard_id"
    t.boolean  "public"
    t.json     "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shard_id"], name: "index_entities_on_shard_id", using: :btree
    t.index ["user_id"], name: "index_entities_on_user_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_games_on_user_id", using: :btree
  end

  create_table "maps", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["game_id"], name: "index_maps_on_game_id", using: :btree
  end

  create_table "obstacles", force: :cascade do |t|
    t.json     "obj"
    t.integer  "user_id"
    t.integer  "shard_id"
    t.boolean  "public"
    t.json     "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shard_id"], name: "index_obstacles_on_shard_id", using: :btree
    t.index ["user_id"], name: "index_obstacles_on_user_id", using: :btree
  end

  create_table "scenes", force: :cascade do |t|
    t.integer  "map_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["map_id"], name: "index_scenes_on_map_id", using: :btree
  end

  create_table "shards", force: :cascade do |t|
    t.integer  "scene_id"
    t.string   "type"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["scene_id"], name: "index_shards_on_scene_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "backgrounds", "shards"
  add_foreign_key "backgrounds", "users"
  add_foreign_key "collaborators", "games"
  add_foreign_key "collaborators", "users"
  add_foreign_key "entities", "shards"
  add_foreign_key "entities", "users"
  add_foreign_key "games", "users"
  add_foreign_key "maps", "games"
  add_foreign_key "obstacles", "shards"
  add_foreign_key "obstacles", "users"
  add_foreign_key "scenes", "maps"
  add_foreign_key "shards", "scenes"
end
