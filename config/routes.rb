MindFinder::Application.routes.draw do
  resources :users


  get "test/new"

  get "index" => "home#index", :as => "index"
	
	root :to => 'home#index'
end
