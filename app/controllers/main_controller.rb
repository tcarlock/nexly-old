class MainController < ApplicationController
  skip_before_filter :authenticate_user!, :except => :dashboard
  
  def welcome
    if signed_in?
      redirect_to dashboard_path
    else
      @signup = BetaSignup.new()
    end
  end
  
  def faqs
  end
  
  def dashboard
    @user = current_user
    @profile = current_user.profile
    @business = current_user.businesses.first
    @platforms = Platform.where(:is_available => true)
    @traffic_stats = TrafficStats.new(@business.id, [@business.created_at, 1.years.ago].max, DateTime.current)
    @pending_reviews = @business.pending_reviews.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end
  
  def open_popup
    PageView.create!(:url => params[:url], 
        :referrer_domain => params[:url].split('/')[2],
        :business_id => params[:bId],
        :reference_id =>params[:rId],
        :link_type_id => params[:tId])
    
    redirect_to params[:url]
  end
  
  def suggest_platform
    suggestion = PlatformSuggestion.create!(params[:platform_suggestion])

    suggestion.update_attributes!(:user_id => current_user.id) if user_signed_in?
    
    FeedbackMailer.new_platform_suggestion_alert(suggestion).deliver
          
    respond_to do |format|
      format.js
    end
  end
  
  def new_feedback
    render :layout => false
  end 
  
  def submit_feedback
    suggestion = Suggestion.create!(params[:suggestion])
    
    suggestion.update_attributes!(:user_id => current_user.id) if user_signed_in?
    
    #FeedbackMailer.new_feedback_alert(suggestion).deliver
          
    respond_to do |format|
      format.js
    end
  end
  
  def test_tweet
    current_user.twitter.update("My Rails 3 App with Omniauth, Devise and Twitter")
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_fb_post
    current_user.facebook.feed!(
      :message => 'Hello, Facebook!', 
      :name => 'My Rails 3 App with Omniauth, Devise and FB_graph'
    )
    
    respond_to do |format|
      format.js
    end
  end
end
