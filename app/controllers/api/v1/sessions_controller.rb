class Api::V1::SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def signin
		@bag = params
		puts "*" * 100
		puts @bag.inspect
		puts "*" * 100

    	user = User.where(username: @bag['username_signin']).first
    	if user && user.valid_password?(params['password_signin'])
    	  render json: user.as_json(only: [:id, :email, :confirmed_at])
    	else
    	  head(:unauthorized)
    	end

	end
end
