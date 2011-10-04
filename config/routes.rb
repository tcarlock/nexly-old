Nexly::Application.routes.draw do  
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
      get :edit_capabilities, :settings
    end

    get :search, :on => :collection
    
    resources :reviews, :except => [:update, :edit], :controller => :reviews do
      member do
        post :dispute, :feature
      end
      
      resources :review_responses, :only => [:new, :create], :controller => :review_responses, :as => :responses
    end
    
    resources :review_requests, :except => [:update, :edit], :controller => :review_requests
    resources :resources, :controller => :resources
  end

  match "dashboard", :to => "main#dashboard"
  match "contact", :to => "main#contact"
  match "faqs", :to => "main#faqs"
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
