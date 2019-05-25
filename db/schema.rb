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

ActiveRecord::Schema.define(version: 2019_05_25_132559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chal", id: :serial, force: :cascade do |t|
    t.integer "ctf_id"
    t.string "name", limit: 40
    t.index ["ctf_id", "name"], name: "chal_ctf_id_name_key", unique: true
  end

  create_table "ctf", id: :serial, force: :cascade do |t|
    t.string "name", limit: 40
  end

  create_table "models", force: :cascade do |t|
    t.string "Solves"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partecipates", primary_key: ["team_id", "ctf_id"], force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "ctf_id", null: false
  end

  create_table "playswith", primary_key: ["user_id", "team_id"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "team_id", null: false
    t.boolean "as_admin"
  end

  create_table "playswiths", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "solves", primary_key: ["user_id", "chal_id", "team_id"], force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chal_id", null: false
    t.integer "team_id", null: false
  end

  create_table "team", id: :serial, force: :cascade do |t|
    t.string "name", limit: 40
  end

  create_table "usr", id: :serial, force: :cascade do |t|
    t.string "username", limit: 30
    t.string "password", limit: 64
    t.string "salt", limit: 5
  end

  add_foreign_key "chal", "ctf", name: "chal_ctf_id_fkey"
  add_foreign_key "partecipates", "ctf", name: "partecipates_ctf_id_fkey"
  add_foreign_key "partecipates", "team", name: "partecipates_team_id_fkey"
  add_foreign_key "playswith", "team", name: "playswith_team_id_fkey"
  add_foreign_key "playswith", "usr", column: "user_id", name: "playswith_user_id_fkey"
  add_foreign_key "solves", "chal", name: "solves_chal_id_fkey"
  add_foreign_key "solves", "team", name: "solves_team_id_fkey"
  add_foreign_key "solves", "usr", column: "user_id", name: "solves_user_id_fkey"
end
