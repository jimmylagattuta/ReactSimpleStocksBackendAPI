class Api::V1::PortfoliosController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token

	def init
		user = User.find_by(id: params['userId'])
		new_port = Portfolio.create(user_id: params['userId'],
								    cash: params['values']['cash_capital']
									)
		if !new_port.investment
			new_port.investment = 0
			new_port.save
		end
		new_investment = params['values']['cash_capital']
		new_investment = new_investment.to_i
		new_port.investment += new_investment
		new_port.save
		user.active_port = true
		user.save
		port = { userId: new_port.user_id,
				 cashCapital: new_port.cash,
				 budget: new_port.cash
			}
		render json: port
	end

	def port_check
		if params[:id]
			user = User.find_by(id: params[:id])
			to_check = Portfolio.find_by(user_id: user.id)
			if to_check
				if to_check.total_capital == nil
					to_check.total_capital = 0
					to_check.save
				end
			end
			if to_check
				if to_check.stock_capital == nil
					to_check.stock_capital = 0
					to_check.save
				end
			end
			if to_check
				stock_cap = to_check.stock_capital
				to_check.total_capital = to_check.cash + to_check.stock_capital
				to_check.save
			end
		end
		if to_check
			if to_check.save
				# puts "stock capital, total capital, and cash start"
				# puts "stock captal " + to_check.stock_capital.to_s
				# puts "total capital " + to_check.total_capital.to_s
				# puts "cash " + to_check.cash.to_s
			end
				# puts "1st stock capital " + to_check.stock_capital.to_s
				# puts "1st total capital " + to_check.total_capital.to_s


		end
		itemarray = []
		if to_check
			to_check.stocks.each do |item|
				itemarray << item
			end
		end
		if itemarray.length != 0
			itemarray.each do |stock|
				stock.portfolio_stocks.each do |stock_port|
					if stock_port.portfolio_id == to_check.id
						# puts "2nd stock captal " + to_check.stock_capital.to_s
						# puts "2nd total capital " + to_check.total_capital.to_s


						symbol = stock_port.symbol
						current_price_per_share = stock_port.current_pps
						look_stock = StockQuote::Stock.quote(symbol)
						if look_stock.symbol == 'CALI'
							puts "*" * 100
							puts 'CALI'
							puts look_stock.inspect
							puts "*" * 100
						end

						if look_stock
							# COMMENT OUT, THIS IS FOR TESTING
							# look_stock.ask = 3.00
						end
						# puts "weird here"
						# puts "look_stock"
						# puts look_stock.inspect
						# puts "look_stock.ask"
						if look_stock.ask == nil || look_stock.ask == 0
							# puts '7' * 100
							symbol = look_stock.symbol
							new_to_check = Stock.find_by(symbol: symbol)
							look_stock.ask = new_to_check.asking_price
						end
						# puts look_stock.ask.to_i
						# puts "current_price_per_share"
						# puts current_price_per_share.to_i

						# look_stock.ask = 3.00
						if look_stock.ask != current_price_per_share
							# puts "8" * 100
							if look_stock.ask != nil
								# puts "9" * 100
								# puts "look != current pps"
								# puts "look_stock.ask below"
								# puts look_stock.ask.to_i
								# puts "current_price_per_share below"
								# puts current_price_per_share.to_i
								if current_price_per_share
									# puts "10" * 100
									# puts "8th stock captal " + to_check.stock_capital.to_s
									# puts "2nd total capital " + to_check.total_capital.to_s
									# puts 'stock_port.quantity ' + stock_port.quantity.to_s 
									old_capital_in_stock = current_price_per_share * stock_port.quantity
									# puts "old_capital_in_stock below"
									# puts old_capital_in_stock.to_i
									# puts 'look_stock ask ' + look_stock.ask.to_s
									new_capital_in_stock = look_stock.ask * stock_port.quantity
									# puts "new_capital_in_stock below"
									# puts new_capital_in_stock.to_i
									if old_capital_in_stock.to_i < 1
										# puts "11" * 100
										# puts "7th stock captal " + to_check.stock_capital.to_s
										# puts "3rd total capital " + to_check.total_capital.to_s
										stock_port.current_pps = look_stock.ask
										stock_port.save
										old_capital_in_stock = stock_port.current_pps
									end
									if to_check.stock_capital < 1
										# puts "12" * 100
										# puts "6th stock captal " + to_check.stock_capital.to_s
										# puts "4th total capital " + to_check.total_capital.to_s
										to_check.cash = to_check.cash - old_capital_in_stock
										to_check.stock_capital = to_check.stock_capital + old_capital_in_stock
										to_check.save
										# puts "10th stock captal " + to_check.stock_capital.to_s
										# puts "5th total capital " + to_check.total_capital.to_s

									end
									# puts "11th stock captal " + to_check.stock_capital.to_s
									# puts "6th total capital " + to_check.total_capital.to_s
									# to_check.stock_capital = to_check.stock_capital - old_capital_in_stock
									# to_check.stock_capital = to_check.stock_capital + new_capital_in_stock
									# puts "12th stock captal " + to_check.stock_capital.to_s
									# puts "to_check stock capital"
									# puts to_check.stock_capital.to_i
									# puts "@_@" * 10
									if old_capital_in_stock > new_capital_in_stock
										# puts "13" * 100
										# puts "5th stock captal " + to_check.stock_capital.to_s
										# puts "7th total capital " + to_check.total_capital.to_s
										# puts "loss"
										total_capital_change = old_capital_in_stock - new_capital_in_stock
										# puts "total_capital_change below"
										# puts total_capital_change.to_i
										to_check.total_capital = to_check.total_capital - total_capital_change
										# puts "bug area 6 stock_capital " + to_check.stock_capital.to_s
										to_check.stock_capital = to_check.stock_capital - total_capital_change


										to_check.save
										# puts "portfolio total capital below***"
										# puts to_check.total_capital
										# puts "9th stock captal " + to_check.stock_capital.to_s
										# puts "8th total capital " + to_check.total_capital.to_s

									elsif old_capital_in_stock < new_capital_in_stock
										# puts "14" * 100
										# puts "4th stock captal " + to_check.stock_capital.to_s
										# puts "9th total capital " + to_check.total_capital.to_s
										# puts "gain"
										# puts 'new_capital_in_stock ' + new_capital_in_stock.to_s
										# puts 'old_capital_in_stock ' + old_capital_in_stock.to_s
										total_capital_change = new_capital_in_stock - old_capital_in_stock
										# puts 'total_capital_change ' + total_capital_change.to_s
										# puts "total_capital_change below"
										# puts total_capital_change.to_i
										# puts 'to_check total capital ' + to_check.total_capital.to_s
										to_check.total_capital = to_check.total_capital + total_capital_change
										# puts 'to_check total capital ' + to_check.total_capital.to_s
										# puts "bug area 7 stock_capital " + to_check.stock_capital.to_s
										to_check.stock_capital = to_check.stock_capital + total_capital_change
										to_check.save
										# puts "portfolio total capital below"
										# puts to_check.total_capital
										# puts "10th total capital " + to_check.total_capital.to_s

									end
								end
							end
							# puts "3rd stock captal " + to_check.stock_capital.to_s

							stock_port.current_pps = look_stock.ask
							stock_port.save
							to_check.save

							if to_check.save
								# puts "@save"
							end
						end
					else
						# puts "look == current pps"
					end 
				end
			end
			if to_check.save
				# puts "stock capital, total capital, and cash end"
				# puts "stock captal " + to_check.stock_capital.to_s
				# puts "total capital " + to_check.total_capital.to_s
				# puts "cash " + to_check.cash.to_s
			end
			# puts "11th total capital " + to_check.total_capital.to_s

		end
		if to_check == nil
			answer = { active: false, user: user.email.split('@').first }
			render json: answer
		else
			port = { id: to_check.id,
					 user: user.email.split('@').first,
					 stock_capital: to_check.stock_capital,
					 cash: to_check.cash,
					 daily_stock_capital_percentage: to_check.daily_stock_capital_percentage,
					 monthly_stock_capital_percentage: to_check.monthly_stock_capital_percentage,
					 yearly_stock_capital_percentage: to_check.yearly_stock_capital_percentage,
					 days_dollar_change: to_check.days_dollar_change,
					 months_dollar_change: to_check.months_dollar_change,
					 years_dollar_change: to_check.years_dollar_change,
					 investment: to_check.investment,
					 all_time_percent: to_check.all_time_percent,
					 all_time_dollar: to_check.all_time_dollar,
					 total_capital: to_check.total_capital
					}
		end
		if to_check != nil
			render json: port
		end
	end

	def destroy
		id = params['id'].to_i
		port = Portfolio.find_by(user_id: id)
		poststocks = PortfolioStock.where(portfolio_id: port.id)
		poststocks.each do |item|
			item.delete
		end
		port.delete 
		user = User.find_by(id: params['id'].to_i)
		user.active_port = false
		user.save
		success_messege = { message: "Portfolio Deleted" } 
		render json: success_messege
	end

	def add_to
		stocks_to_purchase = params['stocks']['stocks_by_symbol']
		portId = params['stocks']['portId']
		portId = portId.to_i
		stocks_to_purchase.each do |stock|
			stock = stock[0, 4]
			stk = Stock.find_by(symbol: stock)
			stk = stk.id
			portfolio_stock = PortfolioStock.new(stock_id: stk, portfolio_id: portId, symbol: stock)
			portfolio_stock.save
			if portfolio_stock.save
				message = { message: "portfolio_stock saved*" }
			else
				message = { message: "portfolio_stock not saved" }
			end
			render json: message
		end 
	end

	def retrieve_the_added_to
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100

		# puts "params"
		# puts params
		# puts "params inspect"
		# puts params.inspect
		# puts = "*" * 100
		port_id = params['data'].to_i        
		stocks = PortfolioStock.where(portfolio_id: port_id)
		stocks_to_buy = []
		stocks.each do |stck|
			if !(stck.pps_at_purchase)
				stockobject = {
					symbol: stck.symbol,
					ask: stck.stock.asking_price,
					portStockId: stck.id
				}
				stocks_to_buy << stockobject
			end
		end
		render json: stocks_to_buy
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100
		# puts = "*" * 100

	end

	def buy_stocks
		message = { message: "params recieved" }
		render json: message
	end

	def buy_stocks_finalize
		total = params['values']['total']
		total = total.to_i
		pps = params['pps']
		pps = pps
		quantity = params['values']['quantity']
		quantity = quantity.to_i
		portId = params['portId']
		portId = portId.to_i
		portStockId = params['portStockId']
		portStockId = portStockId.to_i
		the_port = Portfolio.find_by(id: portId)
		the_port_stock = PortfolioStock.find_by(id: portStockId)
		if the_port
			# puts "*" * 100
			# puts "params"
			# puts params.inspect
			# puts "port here"
			# puts the_port.inspect
			# puts "total here"
			# puts total.inspect
			# puts "$" * 100
			# puts "the port cash"
			# puts the_port.cash
			# puts "$" * 100
			# puts "*" * 100
		end
		# puts "PPS" * 20
		# puts pps
		the_port_stock.pps_at_purchase = pps
		# puts "PPS_AT_PURCHSE" * 20
		# puts the_port_stock.pps_at_purchase
		the_port_stock.current_pps = pps
		the_port_stock.quantity = quantity
		# puts "THE PORT STOCK QUANTITY " + the_port_stock.quantity.to_s
		the_port_stock.save
		the_port.cash = the_port.cash - total
		the_port_stock.capital_at_purchase = the_port_stock.current_pps * the_port_stock.quantity
		if !the_port.stock_capital
			# puts "NULL" * 20
			the_port.stock_capital = 0
			the_port.save
		end
		the_port.stock_capital = the_port.stock_capital + total
		if the_port
			# puts "*" * 100
			# puts "port here"
			# puts the_port.inspect
			# puts "*" * 100
			# puts "$" * 100
			# puts "the port cash"
			# puts the_port.cash
			# puts "the port stock capital"
			# puts the_port.stock_capital
			# puts "$" * 100
		end
		the_port.save
		if the_port.save
			the_port.portfolio_stocks.each do |x|
				x.active_stock = true
				x.save
			end

		end
		render json: the_port_stock
	end

	def port_stocks
		# puts "*" * 100
		# puts "params"
		# puts params
		new_id = params['data']
		new_id = new_id.to_i
		portfolio = Portfolio.find_by(id: new_id)
		# puts 'portfolio'
		# puts portfolio.inspect
		list = []
		id_count = 1
		portfolio.stocks.each do |item|
			quantity = 0
			portfolio.portfolio_stocks.each do |x|
				if x.symbol == item.symbol
					quantity = x.quantity
					# puts " <~QUANTITY~> " * 3
					# puts quantity
				end
			end
			# puts 'about to be new_ask'
			# puts item.bidding_price.round(2)
			# puts 'item again'
			# puts item.bidding_price
			# puts 'item'
			# puts item.inspect
			new_ask = item.bidding_price.round(2)
			# puts 'new_ask'
			# puts new_ask
			info = {
				symbol: item.symbol,
				bid: new_ask,
				id: id_count,
				quantity: quantity
			}
			list.push(info)
			id_count += 1
		end
		# puts "*" * 100
		render json: list
	end

	def save_to_sell
		# puts "*" * 20
		# puts "params to_save"
		# puts params.inspect
		new_port_id = params['data']['portId'].to_i
		bid = params['data']['items']['bid'].slice(0, 1)
		bid_decimal = params['data']['items']['bid'].slice(2, 3)
		correct_bid = bid.to_s + "." + bid_decimal.to_s
		quantity = params['data']['items']['quantity'].to_i
		symbol = params['data']['items']['symbol']
		portfolio = Portfolio.find_by(id: new_port_id)

		portfolio.portfolio_stocks.each do |item|
			if item.pps_at_sale != nil
				item.pps_at_sale = nil && item.active_stock
				item.save
			end
			if item.symbol == symbol
				item.pps_at_sale = correct_bid
				# puts "$$$"
				# puts 'bid'
				# puts bid
				# puts "bid_decimal"
				# puts bid_decimal
				# puts "correct_bid"
				# puts correct_bid
				item.save
			end
		end
		message = { message: 'recieved save_to_sell' }
		# puts "*" * 20
		render json: message		
	end

	def to_sell
		# puts "*" * 20
		# puts "params to_sell"
		port_id = params['data']
		# puts port_id
		item = []
		quantity_owned = 0
		port = Portfolio.find_by(id: port_id)
		port.portfolio_stocks.each do |x|
			if x.pps_at_purchase != nil
				item.push(x)
				# puts "x"
				# puts x.inspect
				# quantity_owned = x.quantity
				# puts "QUANTITY"
				# puts quantity_owned
				# puts 'buying list here'
				# puts item.inspect
			end
		end
		buying = {
			content: item
		}
		# puts "*" * 20
		render json: buying

	end

	def final_sell
		puts "*" * 100
		puts "params"
		puts params.inspect
		quantity_final_sell = params['quantityToBuy']
		quantity_final_sell = quantity_final_sell.to_i
		the_stock_id = params['stockId']
		the_stock_id = the_stock_id.to_i
		portfolio = Portfolio.find_by(id: params['portId'])
		portfolio.portfolio_stocks.each do |item|
			if item.quantity == quantity_final_sell && item.stock_id == the_stock_id
				@portfolio_stock = PortfolioStock.find_by(id: item.id)
			end
		end
		puts "portfolio_stock "
		puts @portfolio_stock.inspect

		message = { message: 'final_sell ready' }
		render json: message
		puts "*" * 100
	end

end
