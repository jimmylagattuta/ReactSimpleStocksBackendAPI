class TryToChangeColumnAgain < ActiveRecord::Migration[5.0]
  def change
  	change_column :portfolio_stocks, :port_id, :decimal, precision: 9, scale: 2
  	change_column :portfolio_stocks, :stock_id, :decimal, precision: 9, scale: 2
  	change_column :portfolio_stocks, :pps_at_purchase, :decimal, precision: 9, scale: 2
  	change_column :portfolio_stocks, :current_pps, :decimal, precision: 9, scale: 2
  	change_column :portfolio_stocks, :pps_at_sale, :decimal, precision: 9, scale: 2
  	change_column :portfolio_stocks, :quantity, :decimal, precision: 9, scale: 2
  end
end
