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

ActiveRecord::Schema.define(version: 20150213032643) do

  create_table "actions", force: true do |t|
    t.string   "action",     limit: 30, null: false
    t.integer  "impact"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "counts", force: true do |t|
    t.integer  "show_id",    null: false
    t.integer  "item_id",    null: false
    t.integer  "quantity",   null: false
    t.boolean  "out",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rate"
    t.integer  "group_id",   null: false
  end

  add_index "counts", ["group_id"], name: "index_counts_on_group_id"
  add_index "counts", ["item_id"], name: "index_counts_on_item_id"
  add_index "counts", ["show_id"], name: "index_counts_on_show_id"

  create_table "groups", force: true do |t|
    t.string   "name",       limit: 50, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "items", force: true do |t|
    t.string   "name",       limit: 50, null: false
    t.string   "sub",        limit: 50
    t.boolean  "active",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "group_id",              null: false
    t.integer  "rate",                  null: false
    t.boolean  "soft",                  null: false
  end

  create_table "locations", force: true do |t|
    t.string   "name",       limit: 50
    t.boolean  "primary",               null: false
    t.boolean  "active",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "group_id"
  end

  create_table "shows", force: true do |t|
    t.date     "date",                  null: false
    t.string   "venue",      limit: 50, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "group_id",              null: false
    t.integer  "tour_id",               null: false
  end

  add_index "shows", ["tour_id"], name: "index_shows_on_tour_id"

  create_table "tours", force: true do |t|
    t.string   "name",       limit: 50, null: false
    t.integer  "group_id",              null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "tours", ["group_id"], name: "index_tours_on_group_id"

  create_table "transactions", force: true do |t|
    t.date     "date",       null: false
    t.integer  "item_id",    null: false
    t.integer  "action_id",  null: false
    t.integer  "quantity",   null: false
    t.integer  "loc1"
    t.integer  "loc2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id",   null: false
    t.integer  "count_id"
    t.integer  "show_id"
  end

  add_index "transactions", ["action_id"], name: "index_transactions_on_action_id"
  add_index "transactions", ["item_id"], name: "index_transactions_on_item_id"
  add_index "transactions", ["show_id"], name: "index_transactions_on_show_id"

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
    t.integer  "group_id",                            null: false
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
