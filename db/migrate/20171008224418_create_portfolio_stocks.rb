class CreatePortfolioStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :portfolio_stocks do |t|
      t.integer :port_id
      t.integer :stock_id
      t.integer :pps_at_purchase
      t.integer :current_pps
      t.integer :pps_at_sale
      t.integer :quantity

      t.timestamps
    end
  end
end
