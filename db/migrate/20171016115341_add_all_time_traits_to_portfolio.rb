class AddAllTimeTraitsToPortfolio < ActiveRecord::Migration[5.0]
  def change
  	add_column :portfolios, :all_time_percent, :decimal, precision: 9, scale: 2
  	add_column :portfolios, :all_time_dollar, :decimal, precision: 9, scale: 2

  end
end
