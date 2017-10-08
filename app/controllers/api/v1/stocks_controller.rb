class Api::V1::StocksController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token



	def index
		@all_stocks = Stock.all
		@stock = params
		puts "*" * 100
		puts "*" * 100
		puts "@stock below"
		puts @stock.inspect
		puts "*" * 100
		puts "*" * 100

		render 'index.json.jbuilder'
	end

	def new
		render 'index.json.jbuilder'
	end

	def create
		@stock = params
		symbol = @stock['symbol']
		@new_stock = StockQuote::Stock.quote(symbol)
		name = @new_stock.name
		year_high = @new_stock.year_high
		year_low = @new_stock.year_low
		asking_price = @new_stock.ask
		bidding_price = @new_stock.bid
		days_percent = @new_stock.changein_percent
		average_daily_volume = @new_stock.average_daily_volume
		days_low = @new_stock.days_low
		days_high = @new_stock.days_high
		puts "$" * 100
		puts "$" * 100
		puts "@new_stock below"
		puts @new_stock.inspect
		puts "$" * 100
		puts "$" * 100
		count = 0
		@stocks = Stock.all
		@stocks.each do |stock|
				puts "*" * 100
				puts "count below"
				puts count
				puts "*" * 100
			if stock['symbol'] == symbol.upcase
				count += 1
				puts "*" * 100
				puts "count below"
				puts count
				puts "*" * 100

			end

		end
		if count == 0
			puts "*" * 100
			puts "count == 0"
			puts "*" * 100

			@new_stock = Stock.create(symbol: @new_stock.symbol,
									  company_name: @new_stock.name,
									  year_high: year_high,
									  year_low: year_low,
									  asking_price: asking_price,
									  bidding_price: bidding_price,
									  days_percent: days_percent,
									  average_daily_volume: average_daily_volume,
									  days_low: days_low,
									  days_high: days_high

									  )
			render 'create.json.jbuilder'

		elsif count > 0
			puts "*" * 100
			puts "count > 0"
			puts "*" * 100
			@new_stock = Stock.new(symbol: @new_stock.symbol,
									  company_name: name,
									  year_high: year_high,
									  year_low: year_low,
									  asking_price: asking_price,
									  bidding_price: bidding_price,
									  changein_percent: days_percent,
									  average_daily_volume: average_daily_volume,
									  days_low: days_low,
									  days_high: days_high

									  )
			render 'create.json.jbuilder'
		end

			# stock_to_frontend = []
			# add_to_front = {
			# 	symbol: @new_stock.symbol,
			# 	companyName: @new_stock.company_name,
			# 	yearHigh: year_high,
			# 	yearLow: year_low,
			# 	askingPrice: asking_price,
			# 	biddingPrice: bidding_price,
			# 	changeInPercent: days_percent,
			# 	averageDailyVolume: average_daily_volume,
			# 	daysLow: days_low,
			# 	daysHigh: days_high
			# }
			# stock_to_frontend.push(add_to_front)
			# puts "*" * 100
			# puts "stock_to_frontend below"
			# puts stock_to_frontend
			# puts "*" * 100

			# render json: stock_to_frontend

	end


end
