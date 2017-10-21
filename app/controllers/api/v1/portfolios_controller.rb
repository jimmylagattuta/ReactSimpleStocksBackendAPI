class Api::V1::PortfoliosController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token

	def init
		user = User.find_by(id: params['userId'])
		new_port = Portfolio.create(user_id: params['userId'],
								    cash: params['values']['cash_capital']
									)
		user.active_port = true
		user.save
		port = { userId: new_port.user_id,
				 cashCapital: new_port.cash
			}
		render json: port
	end

	def port_check
		user = User.find_by(id: params[:id].to_i)
		to_check = Portfolio.find_by(user_id: user.id)
		if to_check == nil
			puts "^_^" * 100
			puts "to_check = nil"
			puts "^_^" * 100
		end
		puts "&" * 100
		puts "to check below"
		puts to_check.inspect
		puts "&" * 100
		if to_check == nil
			puts "*" * 100
			puts "to_check == nil"
			puts "*" * 100
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
					 total_capital: to_check.total_capital,
					 investment: to_check.investment,
					 all_time_percent: to_check.all_time_percent,
					 all_time_dollar: to_check.all_time_dollar
					}
			render json: port
		end
	end

	def destroy
		id = params['id'].to_i
		port = Portfolio.find_by(user_id: id)
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
			puts ">>>>>>>>>>>"
			puts "portId below"
			puts portId.inspect
			portfolio_stock = PortfolioStock.new(stock_id: stk, portfolio_id: portId)
			puts "portfolio_stock here"
			puts portfolio_stock.inspect
			portfolio_stock.save
			puts "errors"
			puts portfolio_stock.errors.full_messages
			if portfolio_stock.save
				puts "saved!"
				message = { message: "portfolio_stock saved*" }
			else
				puts "not saved"
				message = { message: "portfolio_stock not saved" }
			end
			render json: message
		end 
	end

end
