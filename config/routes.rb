Nexly::Application.routes.draw do  
  get "review_responses/new"

  get "review_responses/create"

  get "review_responses/destroy"

  devise_for :users

  resources :users, :only => [] do
    member do
      get :following, :followers, :stats, :controller => 'relationships'
    end
  end
       
  resources :user_profile do
    member do
      get '/' => 'user_profile#show', :as => 'user_profile'
    end

    get :search, :on => :collection
  end

  resources :businesses do
    member do
      get :edit_capabilities, :reviews
    end

    get :search, :on => :collection
    resources :reviews, :except => [:update, :edit], :controller => :reviews
    resources :resources, :controller => :resources
  end

  match "app", :to => "main#home", :as => :app_home
  match "contact", :to => "main#contact", :as => :contact
  match "about", :to => "main#about", :as => :about
  match "create_service_request", :to => "main#create_service_request", :via => :post, :as => "create_request"
  get :search, :to => "main#search"
  
  get "demo/home"
  get "demo/toolbar"
  get "demo/resources"
  get "demo/events"
  get "demo/reviews"
  get "demo/contact"
    
  root :to => "main#welcome"
end
