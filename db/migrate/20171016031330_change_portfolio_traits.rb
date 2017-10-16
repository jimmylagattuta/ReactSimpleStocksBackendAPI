class ChangePortfolioTraits < ActiveRecord::Migration[5.0]
  def change
  	remove_column :portfolios, :annual_stock_capital_gain, :decimal
  	remove_column :portfolios, :monthly_stock_capital_gain, :decimal
  	remove_column :portfolios, :daily_stock_capital_gain, :decimal
  	add_column :portfolios, :days_dollar_change, :decimal, precision: 9, scale: 2
  	add_column :portfolios, :months_dollar_change, :decimal, precision: 9, scale: 2
  	add_column :portfolios, :years_dollar_change, :decimal, precision: 9, scale: 2
  	add_column :portfolios, :investment, :decimal, precision: 9, scale: 2
  end
end
