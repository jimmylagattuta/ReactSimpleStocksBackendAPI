class AdjustIntegersInHistroyofPortfolios < ActiveRecord::Migration[5.0]
  def change
  	change_column :history_of_portfolios, :user_id, :decimal, precision: 9, scale: 2
  	change_column :history_of_portfolios, :portfolio_id, :decimal, precision: 9, scale: 2
  	change_column :history_of_portfolios, :purchases, :decimal, precision: 9, scale: 2
  	change_column :history_of_portfolios, :sales, :decimal, precision: 9, scale: 2
  	change_column :history_of_portfolios, :capital, :decimal, precision: 9, scale: 2
  	change_column :history_of_portfolios, :total_investment, :decimal, precision: 9, scale: 2
  end
end
