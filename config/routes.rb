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
  post "api/v1/port/retrieve_the_added_to" => "api/v1/portfolios#retrieve_the_added_to"
  post "api/v1/port/buy_stocks" => "api/v1/portfolios#buy_stocks"
  post "api/v1/port/buy_stocks_finalize" => "api/v1/portfolios#buy_stocks_finalize"
  get "api/v1/stock_symbols/symbols" => "api/v1/stocks#symbols"
  post "api/v1/port_stocks/get_stocks" => "api/v1/portfolios#port_stocks"
  post "api/v1/port_stocks/to_sell" => "api/v1/portfolios#to_sell"
  post "api/v1/port_stocks/save_to_sell" => "api/v1/portfolios#save_to_sell"

end