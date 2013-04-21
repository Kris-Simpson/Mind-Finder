MindFinder::Application.routes.draw do
  resources :users
  resources :sessions
  resources :rooms
  
  get "index" => "home#index", :as => "index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "profile" => "profile#index", :as => "profile"
  get "rooms" => "rooms#index", :as => "rooms"
	
  match 'change_locale' => 'home#change_locale', :as =>'change_locale'

  namespace :admin do
    
  end

  namespace :user do

  end

  root :to => "home#index"
end