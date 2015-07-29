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

ActiveRecord::Schema.define(version: 20150729010251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ranks", force: :cascade do |t|
    t.string   "initial",    null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ranks", ["initial"], name: "index_ranks_on_initial", unique: true, using: :btree
  add_index "ranks", ["name"], name: "index_ranks_on_name", using: :btree

  create_table "suits", id: false, force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "color",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "initial",    null: false
  end

  add_index "suits", ["color"], name: "index_suits_on_color", using: :btree
  add_index "suits", ["initial"], name: "index_suits_on_initial", unique: true, using: :btree
  add_index "suits", ["name"], name: "index_suits_on_name", unique: true, using: :btree

end