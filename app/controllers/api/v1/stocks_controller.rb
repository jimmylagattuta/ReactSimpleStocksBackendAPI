class Api::V1::StocksController < ApplicationController
	def index
		@default_stock = StockQuote::Stock.quote('aapl')
		# @all_stocks = Stock.all
		# if @all_stocks
			# render 'index.json.jbuilder'
		# end

		puts "$" * 100
		puts "$" * 100
		puts "@default_stock below"
		puts @default_stock.inspect
		puts "$" * 100
		puts "$" * 100

		render 'index.json.jbuilder'



	end

	def new
	end

	def create
		@stock = params
		puts "$" * 100
		puts "$" * 100
		puts "@stock below"
		puts @stock.inspect
		puts "$" * 100
		puts "$" * 100

	end


end
