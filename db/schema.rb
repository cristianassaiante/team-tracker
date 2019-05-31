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

ActiveRecord::Schema.define(version: 2019_05_28_184553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chals", id: :serial, force: :cascade do |t|
    t.integer "ctf_id"
    t.string "name", limit: 40
    t.integer "points"
    t.text "categ"
    t.index ["ctf_id", "name"], name: "chals_ctf_id_name_key", unique: true
  end

  create_table "ctfs", id: :serial, force: :cascade do |t|
    t.string "name", limit: 40
    t.boolean "onsite"
    t.string "location"
    t.index ["name"], name: "ctfs_name_key", unique: true
  end

  create_table "partecipates", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "ctf_id"
    t.index ["team_id", "ctf_id"], name: "partecipates_team_id_ctf_id_key", unique: true
  end

  create_table "solves", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "chal_id"
    t.integer "team_id"
    t.boolean "is_pending", default: true
    t.index ["user_id", "chal_id", "team_id"], name: "solves_user_id_chal_id_team_id_key", unique: true
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "name", limit: 40
    t.string "token", limit: 64
    t.boolean "need_chal_confirmation", default: true
    t.index ["name"], name: "teams_name_key", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.boolean "is_admin", default: false, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "uid"
    t.integer "team_id"
  end

  add_foreign_key "chals", "ctfs", name: "chals_ctf_id_fkey"
  add_foreign_key "partecipates", "ctfs", name: "partecipates_ctf_id_fkey"
  add_foreign_key "partecipates", "teams", name: "partecipates_team_id_fkey"
  add_foreign_key "solves", "chals", name: "solves_chal_id_fkey"
  add_foreign_key "solves", "teams", name: "solves_team_id_fkey"
  add_foreign_key "solves", "users", name: "solves_user_id_fkey"
  add_foreign_key "users", "teams", name: "users_team_id_fkey"
end
