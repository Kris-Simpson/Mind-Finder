MindFinder::Application.routes.draw do
  resources :users
  resources :sessions
  
  get "index" => "users#index", :as => "index"
  get "logout" => "sessions#destroy", :as => "logout"
	
  match 'change_locale' => 'users#change_locale', :as =>'change_locale'

	root :to => 'users#index'
end
