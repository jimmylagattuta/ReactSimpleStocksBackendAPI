class CreatePortfolios < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.decimal :stock_capital
      t.decimal :cash
      t.integer :daily_stock_capital_percentage
      t.integer :monthly_stock_capital_percentage
      t.integer :yearly_stock_capital_percentage
      t.decimal :annual_stock_capital_gain
      t.decimal :monthly_stock_capital_gain
      t.decimal :daily_stock_capital_gain

      t.timestamps
    end
  end
end
