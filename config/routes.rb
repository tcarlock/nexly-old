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
      get :settings
    end

    get :search, :on => :collection
    
    resource :recommendations, :only => [:new, :create]
    resources :reviews, :except => [:update, :edit] do
      member do
        post :dispute, :approve, :reject
      end
      
      resources :review_responses, :only => [:new, :create], :as => :responses
    end
    
    resources :review_requests, :except => [:update, :edit]
    # resources :resources
    resources :authentications, :only => [:index, :create, :destroy]
    resources :subscriptions, :except => :index, :controller => :app_subscriptions, :as => :subscriptions
    resources :analytics, :only => :index, :controller => :analytics
  end
  
  get "plugins/toolbar"
  post "beta_signup/create"
  
  match '/auth/:provider/callback' => 'authentications#create'
  
  get :dashboard, :to => "main#dashboard"
  get :open_popup, :to => "main#open_popup"
  get :modules, :to => "main#modules"
  get :contact, :to => "main#contact"
  get :faqs, :to => "main#faqs"
    
  match "demo/home"
  match "demo/social"
  match "demo/resources"
  match "demo/events"
  match "demo/reviews"
  match "demo/contact"
  
  post "main/test_tweet"
  post "main/test_fb_post"

  root :to => "main#welcome"
end
