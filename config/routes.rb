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
  end

  resources :businesses do
    resource :recommendations, :only => [:new, :create]
    resources :reviews, :except => [:update, :edit] do
      member do
        post :dispute, :approve, :reject
      end
      
      resources :review_responses, :only => [:new, :create], :as => :responses
    end
    
    resources :review_requests, :except => [:update, :edit]
    # resources :resources
  
    resources :analytics, :only => :index, :controller => :analytics
  end
  
  namespace :plugins do
    get :toolbar_render_script
    get :toolbar
  end 
    
  match "/auth/:provider/callback" => "authentications#create"
  match "/auth/failure" => "authentications#failure"
  
  resources :authentications, :only => [:index, :create, :destroy]
  resources :platforms, :only => [] do
    resources :pages, :only => [:index], :controller => :platform_pages, :as => :pages do
      member do
        post :toggle_publishing
      end
    end
  end
  
  get :dashboard, :to => "main#dashboard"
  get :redir, :to => "main#redir"
  get :modules, :to => "main#modules"
  get :contact, :to => "main#contact"
  get :faqs, :to => "main#faqs"
    
  namespace :demo do
    get :home
    get :social
    get :resources
    get :events
    get :reviews
    get :contact    
  end
  
  get :billing, :to => "main#billing"
  get :init_settings, :to => "main#init_settings"
  get :settings, :to => "main#settings"
  resources :subscriptions, :except => :index, :controller => :app_subscriptions, :as => :subscriptions
  post "main/update_billing", :as => :update_billing
  
  post "beta_signup/create"
  post "main/suggest_platform", :as => :suggest_platform
  get :feedback, :to => "main#feedback"
  post "main/submit_feedback", :as => :submit_feedback
  
  post "main/test_tweet"
  post "main/test_li_update"
  post "main/test_fb_post"
  match "test_fbfp_access" => "main#test_fbfp_access"

  root :to => "main#welcome"
end
