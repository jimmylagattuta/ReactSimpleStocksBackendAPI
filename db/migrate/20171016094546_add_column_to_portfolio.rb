class AddColumnToPortfolio < ActiveRecord::Migration[5.0]
  def change
  	add_column :portfolios, :total_capital, :decimal, precision: 9, scale: 2
  end
end
