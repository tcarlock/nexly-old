Nexly::Application.routes.draw do  
  devise_for :users
       
  resources :user_profile do
    member do
      get '/' => 'user_profile#show', :as => 'user_profile'
    end
  end

  resources :businesses do
    resource :recommendations, :only => [:new, :create]
    resources :review_requests, :only => [:new, :create, :destroy]
    resources :reviews, :only => [:show, :new, :create] do
      member do
        post :dispute, :approve, :reject
      end
      
      resources :review_responses, :only => [:new, :create], :as => :responses
    end
    
    resources :news, :controller => :news_posts
    resources :analytics, :only => :index, :controller => :analytics

    get 'review_requests' => 'reviews#review_requests', :as => :business_review_requests_path
    get 'pending_reviews' => 'reviews#pending_reviews'
    get 'approved_reviews' => 'reviews#approved_reviews'
    get 'rejected_reviews' => 'reviews#rejected_reviews'
  end

  get 'features/' => 'settings#features'
  get 'platforms/' => 'settings#platforms'
  get 'init_settings/' => 'settings#init_settings'
  get 'analytics/registrations' => 'analytics#index'
  post 'analytics/track_link' => 'analytics#track_link', :as => :track_link
  post 'settings/toggle_feature/:id' => 'settings#toggle_feature'
  post 'settings/toggle_toolbar_activation' => 'settings#toggle_toolbar_activation'
  post 'settings/toggle_public_reviews' => 'settings#toggle_public_reviews'
  post 'settings/toggle_public_recommendations' => 'settings#toggle_public_recommendations'
  
  namespace :plugins do
    get :plugin_render_script
    get :toolbar
    get :render_content_page
    get :reviews
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
