# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_02_012810) do

  create_table "buy_orders", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "company_id", null: false
    t.integer "sim_time"
    t.decimal "price", precision: 20, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_buy_orders_on_company_id"
    t.index ["player_id"], name: "index_buy_orders_on_player_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "player_assets", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "company_id", null: false
    t.integer "sim_time"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_player_assets_on_company_id"
    t.index ["player_id"], name: "index_player_assets_on_player_id"
  end

  create_table "player_cashes", force: :cascade do |t|
    t.decimal "amount", precision: 20, scale: 2
    t.integer "sim_time"
    t.integer "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_player_cashes_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sell_orders", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "company_id", null: false
    t.integer "sim_time"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_sell_orders_on_company_id"
    t.index ["player_id"], name: "index_sell_orders_on_player_id"
  end

  create_table "stock_prices", force: :cascade do |t|
    t.integer "company_id", null: false
    t.decimal "price", precision: 10, scale: 2
    t.integer "sim_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_stock_prices_on_company_id"
  end

  add_foreign_key "buy_orders", "companies"
  add_foreign_key "buy_orders", "players"
  add_foreign_key "player_assets", "companies"
  add_foreign_key "player_assets", "players"
  add_foreign_key "player_cashes", "players"
  add_foreign_key "sell_orders", "companies"
  add_foreign_key "sell_orders", "players"
  add_foreign_key "stock_prices", "companies"
end
