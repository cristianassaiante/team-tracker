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

ActiveRecord::Schema.define(version: 2019_06_01_095942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

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
    t.integer "age"
    t.string "website"
    t.string "school"
    t.string "nationality"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chals", "ctfs", name: "chals_ctf_id_fkey"
  add_foreign_key "solves", "chals", name: "solves_chal_id_fkey"
  add_foreign_key "solves", "teams", name: "solves_team_id_fkey"
  add_foreign_key "solves", "users", name: "solves_user_id_fkey"
  add_foreign_key "users", "teams", name: "users_team_id_fkey"
end
