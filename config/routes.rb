MindFinder::Application.routes.draw do
  resources :users
  resources :sessions
  
  get "index" => "home#index", :as => "index"
  get "index" => "work#index", :as => "index"
  get "logout" => "sessions#destroy", :as => "logout"
	
  match 'change_locale' => 'home#change_locale', :as =>'change_locale'

  root :to => "home#index"
end