json.set! :stocks do
	json.array! @all_stocks.each do |stock|
		json.symbol stock.symbol
		json.company_name stock.company_name
		json.year_high stock.year_high
		json.year_low stock.year_low
		json.asking_price stock.asking_price
		json.bidding_price stock.bidding_price
		json.average_daily_volume stock.average_daily_volume
		json.days_low stock.days_low
		json.days_high stock.days_high
		json.days_percent stock.days_percent
	end
end