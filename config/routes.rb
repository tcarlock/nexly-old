Nexly::Application.routes.draw do  
  get "analytics/index"

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
      get :edit_capabilities
    end

    get :search, :on => :collection
    
    resource :recommendations, :only => [:new, :create]
    resources :reviews, :except => [:update, :edit] do
      member do
        post :dispute, :approve
      end
      
      resources :review_responses, :only => [:new, :create], :as => :responses
    end
    
    resources :review_requests, :except => [:update, :edit]
    resources :resources
  end
  
  resources :app_subscriptions, :except => :index, :as => :subscriptions

  get :dashboard, :to => "main#dashboard"
  get :open_popup, :to => "main#open_popup"
  get :analytics, :to => "analytics#index"
  get :modules, :to => "main#modules"
  get :contact, :to => "main#contact"
  get :faqs, :to => "main#faqs"
  get :search, :to => "main#search"
    
  get "demo/home"
  get "demo/social"
  get "demo/twitter_auth", :as => "twitter_auth"
  post "demo/process_twitter_token", :as => "process_twitter_token"
  get "demo/toolbar"
  get "demo/resources"
  get "demo/events"
  get "demo/reviews"
  get "demo/contact"
    
  root :to => "main#welcome"
end
