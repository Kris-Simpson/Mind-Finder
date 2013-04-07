MindFinder::Application.routes.draw do
  resources :users
  resources :sessions
  
  get "index" => "users#index", :as => "index"
  get "logout" => "sessions#destroy", :as => "logout"
	
	root :to => 'users#index'
end
