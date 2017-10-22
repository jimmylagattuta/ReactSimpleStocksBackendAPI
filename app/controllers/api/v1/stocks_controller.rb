class Api::V1::StocksController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token
	def index
		@all_stocks = Stock.all
		@all_stocks.each do |stock|
			symbol_for_loop = stock.symbol
			update_stock = StockQuote::Stock.quote(symbol_for_loop)
			if update_stock.ask
				stock.asking_price = update_stock.ask
			end
			if update_stock.bid
				stock.bidding_price = update_stock.bid
			end
			if update_stock.year_high
				stock.year_high = update_stock.year_high
			end
			if update_stock.year_low
				stock.year_low = update_stock.year_low
			end
			if update_stock.changein_percent
				stock.days_percent = update_stock.changein_percent
			end
			if update_stock.average_daily_volume
				stock.average_daily_volume = update_stock.average_daily_volume
			end
			if update_stock.days_high
				stock.days_high = update_stock.days_high
			end
			if update_stock.days_low
				stock.days_low = update_stock.days_low
			end
			stock.save
		end
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
		count = 0
		@stocks = Stock.all
		@stocks.each do |stock|
			if stock['symbol'] == symbol.upcase
				count += 1
			end
		end
		if count == 0
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

	def delete_the_stock
		@stock = Stock.find_by(id: params['stock_id'])
			if @stock
				message = { message: "Delete Successful" }
			else
				message = { message: "Stock was not found" }
			end
		@stock.delete
		render json: message
	end
end
