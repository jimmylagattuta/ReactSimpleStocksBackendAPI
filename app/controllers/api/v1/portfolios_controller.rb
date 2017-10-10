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
		port = { userId: new_port.user_id,
				 cashCapital: new_port.cash
			}
		render json: port
	end

	def port_check
		user = User.find_by(id: params[:id].to_i)
		port_array = []
		if user
			email = user.email
			email = email.split("@")
			email = email.first


			if user.active_port != false
				puts "%" * 100
				puts "user.active_port"
				puts "%" * 100

				answer = { active: true, user: email }
				port_array.push(answer)
			else 
				puts "%" * 100
				puts "user.not active"
				puts "%" * 100
				answer = { active: false, user: email }
				port_array.push(answer)
			end
		end
		render json: port_array
	end

end
