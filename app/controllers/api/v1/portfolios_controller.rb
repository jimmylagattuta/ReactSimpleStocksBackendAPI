class Api::V1::PortfoliosController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token

	def init
		puts "*" * 100
		puts "params"
		puts params.inspect
		puts "*" * 100
	end

	def port_check
		user = User.find_by(id: params[:id].to_i)
		port_array = []
		if user
			email = user.email
			email = email.split("@")
			email = email.first


			if user.active_port
				answer = { active: true, user: email }
				port_array.push(answer)
			else 
				answer = { active: false, user: email }
				port_array.push(answer)
			end
		end
		render json: port_array
	end

end
