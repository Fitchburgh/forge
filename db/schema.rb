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

ActiveRecord::Schema.define(version: 20161116142449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "backgrounds", force: :cascade do |t|
    t.json     "obj"
    t.integer  "user_id"
    t.integer  "game_id"
    t.boolean  "public",     default: true
    t.string   "name"
    t.json     "tags",       default: "",   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["game_id"], name: "index_backgrounds_on_game_id", using: :btree
    t.index ["user_id"], name: "index_backgrounds_on_user_id", using: :btree
  end

  create_table "characters", force: :cascade do |t|
    t.integer  "user_id"
    t.json     "obj"
    t.string   "name"
    t.boolean  "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_characters_on_user_id", using: :btree
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
    t.integer  "game_id"
    t.string   "name"
    t.boolean  "public"
    t.json     "tags",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["game_id"], name: "index_entities_on_game_id", using: :btree
    t.index ["user_id"], name: "index_entities_on_user_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.json     "tags"
    t.integer  "user_id"
    t.string   "description"
    t.json     "obj"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_games_on_user_id", using: :btree
  end

  create_table "maps", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "name"
    t.string   "description"
    t.json     "obj"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["game_id"], name: "index_maps_on_game_id", using: :btree
  end

  create_table "obstacles", force: :cascade do |t|
    t.json     "obj"
    t.integer  "user_id"
    t.integer  "game_id"
    t.string   "name"
    t.boolean  "public"
    t.json     "tags",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["game_id"], name: "index_obstacles_on_game_id", using: :btree
    t.index ["user_id"], name: "index_obstacles_on_user_id", using: :btree
  end

  create_table "save_games", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.json     "obj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_save_games_on_game_id", using: :btree
    t.index ["user_id"], name: "index_save_games_on_user_id", using: :btree
  end

  create_table "scenes", force: :cascade do |t|
    t.integer  "map_id"
    t.integer  "game_id"
    t.string   "name"
    t.string   "description"
    t.json     "obj"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["game_id"], name: "index_scenes_on_game_id", using: :btree
    t.index ["map_id"], name: "index_scenes_on_map_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "token"
    t.string   "uid"
    t.json     "google_oauth_data"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_foreign_key "backgrounds", "games"
  add_foreign_key "backgrounds", "users"
  add_foreign_key "characters", "users"
  add_foreign_key "collaborators", "games"
  add_foreign_key "collaborators", "users"
  add_foreign_key "entities", "games"
  add_foreign_key "entities", "users"
  add_foreign_key "games", "users"
  add_foreign_key "maps", "games"
  add_foreign_key "obstacles", "games"
  add_foreign_key "obstacles", "users"
  add_foreign_key "save_games", "games"
  add_foreign_key "save_games", "users"
  add_foreign_key "scenes", "games"
  add_foreign_key "scenes", "maps"
end
