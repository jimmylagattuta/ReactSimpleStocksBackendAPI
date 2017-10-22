class Api::V1::SessionsController < ApplicationController
  	protect_from_forgery with: :null_session
  	skip_before_action :verify_authenticity_token

	def new
	end

	def create
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			if user.portfolios[0]
				user_budget = user.portfolios[0].cash.to_i
			end
			session[:id] = user.id
			email = user.email.split('@')
			user.email = email.first
			user.budget = user_budget
			if user_budget
			    render json: user.as_json(only: [:id, :email, :budget, :confirmed_at])
			else
				render json: user.as_json(only: [:id, :email, :confirmed_at])
			end
			flash[:success] = "You Have Successfully Logged In"
		else
			flash[:danger] = "Invalid Email or Password"
			redirect_to "/login"
		end
	end

	def destroy
		session[:id] = nil
		user = { status: 'deleted', id: nil }
		render json: user
	end
end
