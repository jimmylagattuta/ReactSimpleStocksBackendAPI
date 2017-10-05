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
		puts "$" * 100
		puts "$" * 100
		puts "@new_stock below"
		puts @new_stock.inspect
		puts "$" * 100
		puts "$" * 100
		@new_stock = Stock.create(symbol: @new_stock.symbol,
								  company_name: @new_stock.name,
								  year_high: @new_stock.year_high,
								  year_low: @new_stock.year_low,
								  asking_price: @new_stock.ask,
								  bidding_price: @new_stock.bid,
								  days_percent: @new_stock.changein_percent,
								  average_daily_volume: @new_stock.average_daily_volume,
								  days_low: @new_stock.days_low,
								  days_high: @new_stock.days_high

								  )
		render 'create.json.jbuilder'

	end


end
