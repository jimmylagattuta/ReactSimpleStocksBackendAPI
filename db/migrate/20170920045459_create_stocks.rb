class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company_name
      t.decimal :year_high
      t.decimal :year_low
      t.decimal :asking_price
      t.decimal :bidding_price
      t.decimal :days_percent
      t.decimal :average_daily_volume
      t.decimal :days_low
      t.decimal :days_high
      t.decimal :changein_percent

      t.timestamps
    end
  end
end
