class AddSymbolToPortfolioStocks < ActiveRecord::Migration[5.0]
  def change
  	add_column :portfolio_stocks, :symbol, :string
  end
end
