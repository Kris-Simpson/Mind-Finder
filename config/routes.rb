MindFinder::Application.routes.draw do
  get "test/new"

  get "index" => "home#index", :as => "index"
	
	root :to => 'home#index'
end
