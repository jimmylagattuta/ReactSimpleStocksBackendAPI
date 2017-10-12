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

ActiveRecord::Schema.define(version: 20171011221656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "portfolio_stocks", force: :cascade do |t|
    t.decimal  "port_id",         precision: 9, scale: 2
    t.decimal  "stock_id",        precision: 9, scale: 2
    t.decimal  "pps_at_purchase", precision: 9, scale: 2
    t.decimal  "current_pps",     precision: 9, scale: 2
    t.decimal  "pps_at_sale",     precision: 9, scale: 2
    t.decimal  "quantity",        precision: 9, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "stock_capital"
    t.decimal  "cash"
    t.integer  "daily_stock_capital_percentage"
    t.integer  "monthly_stock_capital_percentage"
    t.integer  "yearly_stock_capital_percentage"
    t.decimal  "annual_stock_capital_gain"
    t.decimal  "monthly_stock_capital_gain"
    t.decimal  "daily_stock_capital_gain"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol"
    t.string   "company_name"
    t.decimal  "year_high"
    t.decimal  "year_low"
    t.decimal  "asking_price"
    t.decimal  "bidding_price"
    t.decimal  "days_percent"
    t.decimal  "average_daily_volume"
    t.decimal  "days_low"
    t.decimal  "days_high"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "notes"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "admin"
    t.boolean  "active_port"
    t.integer  "portfolios"
  end

end
