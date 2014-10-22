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

ActiveRecord::Schema.define(version: 20141017000235) do

  create_table "bills", force: true do |t|
    t.decimal  "owed",     precision: 10, scale: 2
    t.boolean  "late",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "person_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_log_message", default: false
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.decimal  "owes",            default: 0.0
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "email_me",        default: true
    t.string   "remember_token"
  end

  add_index "people", ["remember_token"], name: "index_people_on_remember_token"
end
