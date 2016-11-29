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

ActiveRecord::Schema.define(version: 20161129060434) do

  create_table "table_webhook_records", force: :cascade do |t|
    t.string   "topic",           limit: 255
    t.text     "content",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action",          limit: 255
    t.string   "webhook_user_id", limit: 255
  end

  create_table "webhook_users", force: :cascade do |t|
    t.string   "webhook_user_value", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
