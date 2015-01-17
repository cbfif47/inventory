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

ActiveRecord::Schema.define(version: 20150117072613) do

  create_table "actions", force: true do |t|
    t.string   "action"
    t.integer  "impact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "sub"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.boolean  "available"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prerolls", force: true do |t|
    t.date     "date"
    t.integer  "action_id"
    t.integer  "loc1"
    t.integer  "loc2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "prerolls", ["action_id"], name: "index_prerolls_on_action_id"

  create_table "transactions", force: true do |t|
    t.date     "date"
    t.integer  "item_id"
    t.integer  "action_id"
    t.integer  "quantity"
    t.integer  "loc1"
    t.integer  "loc2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["action_id"], name: "index_transactions_on_action_id"
  add_index "transactions", ["item_id"], name: "index_transactions_on_item_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
