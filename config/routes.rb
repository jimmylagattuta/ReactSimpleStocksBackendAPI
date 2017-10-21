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
  get "api/v1/news" => "api/v1/stocks#news"
  post "api/v1/port/port_check" => "api/v1/portfolios#port_check"
  post "api/v1/portfolios/init" => "api/v1/portfolios#init"
  post "api/v1/port/destroy" => "api/v1/portfolios#destroy"
  post "api/v1/stocks/delete_the_stock" => "api/v1/stocks#delete_the_stock"
  post "api/v1/port/add_to" => "api/v1/portfolios#add_to"
end