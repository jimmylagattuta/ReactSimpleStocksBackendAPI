class ApplicationController < ActionController::Base
  	protect_from_forgery with: :null_session

  	def current_user
  		@current_user ||= User.find_by(id: session[:id]) if session[:id]
  	end
  	helper_method :current_user

end
