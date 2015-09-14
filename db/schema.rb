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

ActiveRecord::Schema.define(version: 20150913233650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hand_cards", force: :cascade do |t|
    t.integer  "hand_id",                   null: false
    t.string   "card_id",                   null: false
    t.integer  "order",                     null: false
    t.boolean  "face_up",    default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "hand_cards", ["card_id"], name: "index_hand_cards_on_card_id", using: :btree
  add_index "hand_cards", ["hand_id"], name: "index_hand_cards_on_hand_id", using: :btree

  create_table "hands", force: :cascade do |t|
    t.integer  "round_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "position",   null: false
  end

  add_index "hands", ["round_id"], name: "index_hands_on_round_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
  end

  add_index "players", ["user_id"], name: "index_players_on_user_id", using: :btree

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

  create_table "rounds", force: :cascade do |t|
    t.integer  "table_id",                                 null: false
    t.datetime "initial_betting_closed_at",                null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "active",                    default: true, null: false
  end

  add_index "rounds", ["table_id"], name: "index_rounds_on_table_id", using: :btree

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

  create_table "table_player_position_events", force: :cascade do |t|
    t.integer  "table_id",   null: false
    t.integer  "player_id",  null: false
    t.integer  "position",   null: false
    t.integer  "event",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "table_player_position_events", ["player_id"], name: "index_table_player_position_events_on_player_id", using: :btree
  add_index "table_player_position_events", ["table_id"], name: "index_table_player_position_events_on_table_id", using: :btree

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
    t.integer  "round_initial_betting_window_seconds",                            default: 30,    null: false
    t.integer  "minimum_wager_amount",                                                            null: false
    t.integer  "minimum_players_per_round",                                       default: 1,     null: false
  end

  add_index "table_rule_sets", ["name"], name: "index_table_rule_sets_on_name", unique: true, using: :btree

  create_table "tables", force: :cascade do |t|
    t.integer  "table_rule_set_id",                null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "open",              default: true, null: false
  end

  add_index "tables", ["table_rule_set_id"], name: "index_tables_on_table_rule_set_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "kind",       null: false
    t.decimal  "amount",     null: false
    t.integer  "player_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["player_id"], name: "index_transactions_on_player_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "wagers", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "hand_id",                null: false
    t.integer  "player_id",              null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "kind",       default: 0, null: false
  end

  add_index "wagers", ["hand_id"], name: "index_wagers_on_hand_id", using: :btree
  add_index "wagers", ["player_id"], name: "index_wagers_on_player_id", using: :btree

  add_foreign_key "hand_cards", "hands"
  add_foreign_key "hands", "rounds"
  add_foreign_key "players", "users"
  add_foreign_key "rounds", "tables"
  add_foreign_key "table_player_position_events", "players"
  add_foreign_key "table_player_position_events", "tables"
  add_foreign_key "table_player_positions", "players"
  add_foreign_key "table_player_positions", "tables"
  add_foreign_key "tables", "table_rule_sets"
  add_foreign_key "transactions", "players"
  add_foreign_key "wagers", "hands"
  add_foreign_key "wagers", "players"
end
