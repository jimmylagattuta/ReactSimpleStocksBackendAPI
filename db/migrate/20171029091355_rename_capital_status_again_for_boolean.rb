class RenameCapitalStatusAgainForBoolean < ActiveRecord::Migration[5.0]
  def change
  	add_column :portfolio_stocks, :active_stock, :boolean
  end
end
