class RenameCapitalStatusAgain < ActiveRecord::Migration[5.0]
  def change
  	rename_column :portfolio_stocks, :capital_at_purchse_status, :active
  	# change_column :portfolio_stocks, :active, :boolean
  end
end
