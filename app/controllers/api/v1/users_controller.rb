class Api::V1::UsersController < ApplicationController
	skip_before_action :verify_authenticity_token
	# protect_from_forgery with: :null_session


	def index

	end


	def new

	end


	def create
		@bag = params
		puts "*" * 100
		puts @bag.inspect
		puts "*" * 100
		email = @bag['email']
		user = User.new(
			email: email,
			password: @bag['password'],
			password_confirmation: @bag['password_confirmation']
			)
		session[:id] = user.id
		user.save
		if user.save
			puts 'SAVED'
		else
			puts 'something went wrong'
		end	
		user_json = { email: email, session: session }
		render json: user_json
	end


	def update

	end


	def destroy

	end

end
