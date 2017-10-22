class Api::V1::UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	# protect_from_forgery with: :null_session


	def index

	end


	def new

	end


	def create
		@bag = params
		email = @bag['email']
		user = User.new(
			email: email,
			password: @bag['password'],
			password_confirmation: @bag['password_confirmation']
			)
		session[:id] = user.id
		user.save
		user_json = { email: email, session: session }
		render json: user_json
	end


	def update

	end


	def destroy

	end

end
