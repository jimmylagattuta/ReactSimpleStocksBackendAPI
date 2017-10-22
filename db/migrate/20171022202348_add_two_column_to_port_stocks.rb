class AddTwoColumnToPortStocks < ActiveRecord::Migration[5.0]
  def change
  	add_column :portfolio_stocks, :capital_at_purchase, :decimal, precision: 9, scale: 2
  	add_column :portfolio_stocks, :capital_at_purchse_status, :decimal, precision: 9, scale: 2
  end
end
