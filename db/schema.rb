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

ActiveRecord::Schema.define(version: 20150910152832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.string   "initial",                   null: false
    t.string   "name",                      null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "values",     default: "[]"
    t.integer  "order",                     null: false
  end

  add_index "ranks", ["initial"], name: "index_ranks_on_initial", unique: true, using: :btree
  add_index "ranks", ["name"], name: "index_ranks_on_name", using: :btree
  add_index "ranks", ["order"], name: "index_ranks_on_order", unique: true, using: :btree

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

  create_table "table_player_positions", force: :cascade do |t|
    t.integer  "table_id",   null: false
    t.integer  "position",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "player_id",  null: false
    t.integer  "order",      null: false
  end

  add_index "table_player_positions", ["player_id"], name: "index_table_player_positions_on_player_id", using: :btree
  add_index "table_player_positions", ["table_id"], name: "index_table_player_positions_on_table_id", using: :btree

  create_table "table_rule_sets", force: :cascade do |t|
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
    t.string   "name"
    t.integer  "deck_count",                                                                      null: false
    t.integer  "player_position_count",                                                           null: false
    t.integer  "maximum_players_per_position",                                                    null: false
    t.integer  "maximum_bets_per_player",                                                         null: false
    t.boolean  "no_hole_card",                                                    default: false, null: false
    t.boolean  "original_bets_only"
    t.boolean  "initial_player_card_face_up",                                     default: true,  null: false
    t.decimal  "blackjack_pay_out",                                                               null: false
    t.decimal  "standard_pay_out",                                                                null: false
    t.integer  "dealer_stands_at",                                                default: 17,    null: false
    t.boolean  "dealer_draws_if_soft_stand_at",                                   default: false, null: false
    t.integer  "surrender",                                                       default: 0,     null: false
    t.decimal  "surrender_percentage"
    t.boolean  "insurance_available",                                             default: true,  null: false
    t.decimal  "insurance_pay_out"
    t.boolean  "dealer_match_available",                                          default: true,  null: false
    t.decimal  "dealer_match_pay_out"
    t.decimal  "double_down_minimum_percentage",                                  default: 1.0,   null: false
    t.decimal  "double_down_maximum_percentage",                                  default: 1.0,   null: false
    t.boolean  "split_identical_ranks_only",                                      default: false, null: false
    t.integer  "maximum_double_count_per_hand"
    t.integer  "maximum_split_count_per_hand"
    t.boolean  "may_hit_split_aces",                                              default: false, null: false
    t.boolean  "non_controlling_player_chooses_split_hand_to_bet_if_not_followi", default: false, null: false
    t.boolean  "player_must_stand_on_soft_21",                                    default: true,  null: false
    t.text     "restrict_doubling_to_hard_totals"
    t.boolean  "dealer_wins_ties",                                                default: false, null: false
  end

  add_index "table_rule_sets", ["name"], name: "index_table_rule_sets_on_name", unique: true, using: :btree

  create_table "tables", force: :cascade do |t|
    t.integer  "table_rule_set_id", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "tables", ["table_rule_set_id"], name: "index_tables_on_table_rule_set_id", using: :btree

  add_foreign_key "table_player_positions", "players"
  add_foreign_key "table_player_positions", "tables"
  add_foreign_key "tables", "table_rule_sets"
end
