Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # admin email: jimmy.lagattuta@gmail.com
  # admin password: 1234 
 
  namespace :api do
  	namespace :v1 do
  		resources :stocks
  	end
  end

  namespace :api do
  	namespace :v1 do
  		resources :portfolios
  	end
  end

  namespace :api do
  	namespace :v1 do 
  		resources :users
  	end
  end
  namespace :api do
  	namespace :v1 do
  		resources :sessions
  	end  	
  end
  post "api/v1/user_logout" => "api/v1/sessions#destroy"
end
	