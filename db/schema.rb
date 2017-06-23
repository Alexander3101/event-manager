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

ActiveRecord::Schema.define(version: 20170622084335) do

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "begin_datetime", null: false
    t.datetime "end_datetime", null: false
    t.text "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events_rooms", id: false, force: :cascade do |t|
    t.integer "room_id", null: false
    t.integer "event_id", null: false
    t.index ["event_id"], name: "index_events_rooms_on_event_id"
    t.index ["room_id"], name: "index_events_rooms_on_room_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "begin_datetime", null: false
    t.datetime "end_datetime", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "title", null: false
    t.time "begin_work_time", null: false
    t.time "end_work_time", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role", default: "user", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
