class RenameColumnCapitalAtSale < ActiveRecord::Migration[5.0]
  def change
  	rename_column :portfolio_stocks, :capital_at_purchase, :capital_gain_or_loss
  end
end
