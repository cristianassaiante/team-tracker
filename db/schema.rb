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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chals", id: :serial, force: :cascade do |t|
    t.integer "ctf_id"
    t.string "name", limit: 40
    t.index ["ctf_id", "name"], name: "chals_ctf_id_name_key", unique: true
  end

  create_table "ctfs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 40
  end

  create_table "partecipates", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "ctf_id"
    t.index ["team_id", "ctf_id"], name: "partecipates_team_id_ctf_id_key", unique: true
  end

  create_table "solves", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "chal_id"
    t.integer "team_id"
    t.index ["user_id", "chal_id", "team_id"], name: "solves_user_id_chal_id_team_id_key", unique: true
  end

  create_table "team_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.boolean "as_admin"
    t.index ["user_id", "team_id"], name: "team_users_user_id_team_id_key", unique: true
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "name", limit: 40
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 30
    t.string "password", limit: 64
    t.string "salt", limit: 5
  end

  add_foreign_key "chals", "ctfs", name: "chals_ctf_id_fkey"
  add_foreign_key "partecipates", "ctfs", name: "partecipates_ctf_id_fkey"
  add_foreign_key "partecipates", "teams", name: "partecipates_team_id_fkey"
  add_foreign_key "solves", "chals", name: "solves_chal_id_fkey"
  add_foreign_key "solves", "teams", name: "solves_team_id_fkey"
  add_foreign_key "solves", "users", name: "solves_user_id_fkey"
  add_foreign_key "team_users", "teams", name: "team_users_team_id_fkey"
  add_foreign_key "team_users", "users", name: "team_users_user_id_fkey"
end