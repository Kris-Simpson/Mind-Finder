MindFinder::Application.routes.draw do
  resources :users
  resources :sessions
  
  get "index" => "home#index", :as => "index"
  get "workpath" => "work#index", :as => "workpath"
  get "logout" => "sessions#destroy", :as => "logout"
	
  match 'change_locale' => 'home#change_locale', :as =>'change_locale'

  namespace :admin do
    
  end

  namespace :user do
    
  end

  root :to => "home#index"
end