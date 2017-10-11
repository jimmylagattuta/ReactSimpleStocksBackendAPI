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
			answer = { active: false, user: user.email.split('@').first }
		else
			answer = { active: true, user: user.email.split('@').first }
		end
		render json: answer
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
		port = Portfolio.find_by(user_id: params['id'])
		port.delete 
		user = User.find_by(id: params['id'])
		user.active_port = false
		user.save
		success_messege = { message: "Portfolio Deleted" } 
		render json: success_messege
	end

end
