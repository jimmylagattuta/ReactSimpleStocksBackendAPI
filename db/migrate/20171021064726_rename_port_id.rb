class RenamePortId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :portfolio_stocks, :port_id, :portfolio_id
  end
end
