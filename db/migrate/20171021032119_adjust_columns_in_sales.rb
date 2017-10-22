class AdjustColumnsInSales < ActiveRecord::Migration[5.0]
  def change
  	change_column :purchase_and_sales, :portfolio_id, :decimal, precision: 9, scale: 2
  	change_column :purchase_and_sales, :user_id, :decimal, precision: 9, scale: 2
  end
end
