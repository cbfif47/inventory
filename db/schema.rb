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

ActiveRecord::Schema.define(version: 20150113230133) do

  create_table "actions", force: true do |t|
    t.string   "action"
    t.integer  "impact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "sub"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.boolean  "available"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prerolls", force: true do |t|
    t.date     "date"
    t.integer  "action_id"
    t.integer  "loc1"
    t.integer  "loc2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prerolls", ["action_id"], name: "index_prerolls_on_action_id"

  create_table "transactions", force: true do |t|
    t.date     "date"
    t.integer  "item_id"
    t.integer  "action_id"
    t.integer  "quantity"
    t.integer  "loc1"
    t.integer  "loc2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["action_id"], name: "index_transactions_on_action_id"
  add_index "transactions", ["item_id"], name: "index_transactions_on_item_id"

end
