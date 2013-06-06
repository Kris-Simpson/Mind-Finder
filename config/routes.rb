MindFinder::Application.routes.draw do
  resources :who_passeds
  resources :users
  resources :sessions
  resources :rooms
  resources :tests
  resources :questions
  resources :answers
  resources :passed_tests
  resources :tests_allowed_users
  resources :rooms_allowed_users
  resources :password_resets
  
  get "index" => "home#index", :as => "index"
  get "logout" => "sessions#destroy", :as => "logout"
  get "profile" => "profile#index", :as => "profile"
  get "rooms" => "rooms#index", :as => "rooms"
  get "tests" => "tests#index", :as => "tests"
  get 'reset_password' => 'password_resets#new', as: 'reset_password'
  
  post 'test_passed' => 'tests#test_passed', as: :test_passed
  post 'tests_user_allowed' => 'tests#user_allowed', as: :tests_user_allowed
  post 'rooms_user_allowed' => 'rooms#user_allowed', as: :rooms_user_allowed
	
  match 'change_locale' => 'application#change_locale', :as => 'change_locale'

  namespace :admin do
    
  end

  namespace :user do

  end

  root to: "home#index"
end