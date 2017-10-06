class Api::V1::UsersController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index

	end


	def new

	end


	def create
		@bag = params
		puts "*" * 100
		puts @bag.inspect
		puts "*" * 100
		username = @bag['username']
		email = @bag['email']
		user = User.create(
			username: username,
			password: @bag['password'],
			password_confirmation: @bag['password_confirmation'],
			email: email
			)
		if user.save
			puts 'SAVED'
			jsonuser = { username: username,
						 email: email}
						 render json: jsonuser
		else
			puts 'something went wrong'
		end

	end


	def update

	end


	def destroy

	end

end
