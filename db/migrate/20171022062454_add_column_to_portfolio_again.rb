class AddColumnToPortfolioAgain < ActiveRecord::Migration[5.0]
  def change
  	add_column :portfolios, :total_capital_to_delete, :decimal, precision: 9, scale: 2
  end
end
