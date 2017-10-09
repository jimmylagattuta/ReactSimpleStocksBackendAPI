class AddNotesToStocks < ActiveRecord::Migration[5.0]
  def change
  	add_column :stocks, :notes, :text
  end
end
