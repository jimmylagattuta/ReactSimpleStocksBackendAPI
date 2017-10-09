class Api::V1::SessionsController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token

	def new
	end

	def create
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			puts "*" * 100
			puts "authenticated"
			puts "*" * 100
			session[:id] = user.id
			puts "*" * 100
			puts session[:id]
			# email = user.email
			email = user.email.split('@')
			user.email = email.first
			puts "*" * 100
		    render json: user.as_json(only: [:id, :email, :confirmed_at])
			flash[:success] = "You Have Successfully Logged In"
		else
			puts "*" * 100
			puts "not authenticated"
			puts "*" * 100
			flash[:danger] = "Invalid Email or Password"
			redirect_to "/login"
		end
	end

	def destroy
		# if session[:id]
			puts "*" * 100
			puts session[:id]
			puts "*" * 100
			session[:id] = nil
		# else	
			puts "*" * 100
			puts session[:id]
			puts "*" * 100

		# end
			user = { status: 'deleted', id: nil }
			render json: user
	end
end
