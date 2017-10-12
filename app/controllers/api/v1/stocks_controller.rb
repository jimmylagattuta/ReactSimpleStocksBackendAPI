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
		notes = @new_stock.notes
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
									  days_high: days_high,
									  notes: notes

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
									  days_percent: days_percent,
									  average_daily_volume: average_daily_volume,
									  days_low: days_low,
									  days_high: days_high,
									  notes: notes

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

	def news
		require "net/http"
		require "json"
		puts "51" * 100
		@all_stocks = Stock.all
		puts "52" * 100
		news_array = []
		puts "53" * 100
		variable = 'goog'
		puts "54" * 100
		capital_variable = variable.upcase
		puts "55" * 100
		# username = "21856d45863b11db5677abfaa5e51d8d"
		puts "56" * 100
		# password = "38e3ff3446b9e4e6138148c03d639de4"
		puts "57" * 100
		
		init_response = Unirest.get "https://api.intrinio.com/companies?ticker=#{capital_variable}", auth:{:user=>"21856d45863b11db5677abfaa5e51d8d", :password=>"38e3ff3446b9e4e6138148c03d639de4"}
		puts "58" * 100
		response = init_response.body
		puts "59" * 100
		# company = JSON.parse(response)
		puts "60" * 100
		puts "$" * 100
		puts response
		puts "$" * 100

		# @response = Unirest.get('https://api.intrinio.com/companies?identifier={variable}')
		# puts "*" * 100
		# puts "response below"
		# puts @response.inspect
		# puts "*" * 100
		# puts "response below"
		# puts @response.raw_body
		# puts "*" * 100

		news_array.push(response)

		render json: news_array

	end

	def destroy
		@stock = Stock.find_by(params[id: stock_id])
		@stock.delete
		message = { message: "Delete Successful" }
		render json: message
	end


end
