class Api::V1::PortfoliosController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token

	def init
		puts "*" * 100
		puts "params"
		puts params.inspect
		puts session[:id]
		puts "*" * 100
		user = User.find_by(id: params['userId'])
		new_port = Portfolio.create(user_id: params['userId'],
								    cash: params['values']['cash_capital'])
		user.active_port = true
		user.save
		puts "?" * 100
		puts "?" * 100
		puts "?" * 100
		puts "user errors below"
		puts user.errors.full_messages
		puts "?" * 100
		puts "?" * 100
		puts "?" * 100


		port = { userId: new_port.user_id,
				 cashCapital: new_port.cash
			}
		render json: port
	end

	def port_check
		user = User.find_by(id: params[:id].to_i)
		to_check = Portfolio.find_by(user_id: user.id)
		puts "@#@" * 100
		puts "@#@" * 100
		puts to_check.inspect
		puts "@#@" * 100
		puts "@#@" * 100

		if to_check == nil
			puts "^_^" * 100
			puts "^_^" * 100
			puts "to_check = nil"
			puts "^_^" * 100
			puts "^_^" * 100
		end
		puts "&" * 100
		puts "&" * 100
		puts "&" * 100
		puts "to check below"
		puts to_check.inspect
		puts "&" * 100
		puts "&" * 100
		puts "&" * 100
		if to_check == nil
			puts "*" * 100
			puts "to_check == nil"
			puts "*" * 100
			answer = { active: false, user: user.email.split('@').first }
			render json: answer
		else
			puts "*" * 100
			puts "to_check == true"
			puts "*" * 100
			port = { id: to_check.id,
					 stock_capital: to_check.stock_capital,
					 cash: to_check.cash,
					 daily_stock_capital_percentage: to_check.daily_stock_capital_percentage,
					 monthly_stock_capital_percentage: to_check.monthly_stock_capital_percentage,
					 yearly_stock_capital_percentage: to_check.yearly_stock_capital_percentage,
					 days_dollar_change: to_check.days_dollar_change,
					 months_dollar_change: to_check.months_dollar_change,
					 years_dollar_change: to_check.years_dollar_change,
					 total_capital: to_check.total_capital,
					 investment: to_check.investment }
			puts "()" * 100
			puts "port below"
			puts port.inspect
			puts "()" * 100
			render json: port
		end
	end

	def destroy
		puts "%" * 100
		puts "%" * 100
		puts "%" * 100
		puts "destory actvated"
		puts 'params below'
		puts params.inspect
		puts "%" * 100
		puts "%" * 100
		puts "%" * 100
		id = params['id'].to_i
		puts "%" * 100
		puts "%" * 100
		puts "%" * 100
		puts "id below me"
		puts id.inspect
		puts "%" * 100
		puts "%" * 100
		puts "%" * 100

		port = Portfolio.find_by(user_id: id)
		puts "%" * 100
		puts "%" * 100
		puts "port right here!!!!!!!!!!!!!"
		puts port.inspect
		puts "%" * 100
		puts "%" * 100

		port.delete 
		user = User.find_by(id: params['id'].to_i)
		user.active_port = false
		user.save
		success_messege = { message: "Portfolio Deleted" } 
		render json: success_messege
	end

end
