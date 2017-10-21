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

ActiveRecord::Schema.define(version: 20171021064726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "history_of_portfolios", force: :cascade do |t|
    t.decimal  "user_id",                    precision: 9, scale: 2
    t.decimal  "portfolio_id",               precision: 9, scale: 2
    t.text     "notes"
    t.decimal  "purchases",                  precision: 9, scale: 2
    t.decimal  "sales",                      precision: 9, scale: 2
    t.string   "gain_or_loss"
    t.decimal  "capital",                    precision: 9, scale: 2
    t.boolean  "completed_without_error"
    t.text     "sales_notes"
    t.text     "purchases_notes"
    t.decimal  "total_investment",           precision: 9, scale: 2
    t.string   "total_investment_breakeven"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "portfolio_stocks", force: :cascade do |t|
    t.decimal  "portfolio_id",    precision: 9, scale: 2
    t.decimal  "stock_id",        precision: 9, scale: 2
    t.decimal  "pps_at_purchase", precision: 9, scale: 2
    t.decimal  "current_pps",     precision: 9, scale: 2
    t.decimal  "pps_at_sale",     precision: 9, scale: 2
    t.decimal  "quantity",        precision: 9, scale: 2
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "symbol"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "stock_capital"
    t.decimal  "cash"
    t.integer  "daily_stock_capital_percentage"
    t.integer  "monthly_stock_capital_percentage"
    t.integer  "yearly_stock_capital_percentage"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "days_dollar_change",               precision: 9, scale: 2
    t.decimal  "months_dollar_change",             precision: 9, scale: 2
    t.decimal  "years_dollar_change",              precision: 9, scale: 2
    t.decimal  "investment",                       precision: 9, scale: 2
    t.decimal  "total_capital",                    precision: 9, scale: 2
    t.decimal  "all_time_percent",                 precision: 9, scale: 2
    t.decimal  "all_time_dollar",                  precision: 9, scale: 2
  end

  create_table "purchase_and_sales", force: :cascade do |t|
    t.decimal  "portfolio_id", precision: 9, scale: 2
    t.decimal  "user_id",      precision: 9, scale: 2
    t.string   "status"
    t.string   "p_or_s"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
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
