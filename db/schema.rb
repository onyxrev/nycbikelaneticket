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

ActiveRecord::Schema.define(version: 20131007035516) do

  create_table "plaintiffs", force: true do |t|
    t.string   "fullname"
    t.string   "street_address1"
    t.string   "street_address1_encrypted"
    t.string   "street_address2"
    t.string   "street_address2_encrypted"
    t.string   "postal_code"
    t.string   "postal_code_encrypted"
    t.string   "email"
    t.string   "email_encrypted"
    t.string   "phone"
    t.string   "phone_encrypted"
    t.boolean  "is_public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "auth_hash"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "number"
    t.integer  "fine_cents"
    t.integer  "expenses_cents"
    t.string   "location"
    t.datetime "date"
    t.string   "officer_id"
    t.datetime "hearing_date"
    t.integer  "hearing_verdict"
    t.datetime "appeal_date"
    t.integer  "appeal_verdict"
    t.text     "description"
    t.integer  "plaintiff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

end
