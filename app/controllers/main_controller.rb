class MainController < ApplicationController
  if Rails.env == "development" || Rails.env == "demo"
    skip_before_filter :authenticate_user!
  else
    skip_before_filter :authenticate_user!, :except => :dashboard
  end
  
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
    if Rails.env == "development" || Rails.env == "demo" || Rails.env == "test"
      sign_in User.find(1)
    end
    
    @user = current_user
    @profile = current_user.profile
    @business = current_user.business
    @platforms = Platform.where(:is_available => true)
    
    @business.active_features

    @active_feature_count = 1   # @business.active_features.count
    @enable_reviews = true   # !@business.active_features.where(:lookup_key => "reviews").empty?
    @enable_news = false   # !@business.active_features.where(:lookup_key => "news").empty?

    @pending_reviews = @business.pending_reviews.order('created_at DESC').paginate(:page => params[:reviews_pg], :per_page => 5)
    @news_posts = @business.news_posts.order('created_at DESC').paginate(:page => params[:news_pg])
    @traffic = @business.traffic_browser([@business.created_at, 12.months.ago].max, DateTime.current)
  end
  
  def redir
    PageView.create(:url => params[:url],
        :business_id => params[:bId],
        :reference_id =>params[:rId],
        :link_type_id => params[:tId],
        :platform_id => params[:pId],
        :ip_address => request.env['REMOTE_ADDR'])
    
    redirect_to params[:url]
  end
  
  def suggest_platform
    suggestion = PlatformSuggestion.create(params[:platform_suggestion])

    if suggestion.valid?
      suggestion.update_attributes(:user_id => current_user.id) if user_signed_in?
    
      FeedbackMailer.new_platform_suggestion_alert(suggestion).deliver
          
      respond_to do |format|
        format.js
      end
    end
  end
  
  def feedback
    render :layout => false
  end 
  
  def submit_feedback
    suggestion = Suggestion.create(params[:suggestion])
    
    if suggestion.valid?
      suggestion.update_attributes(:user_id => current_user.id) if user_signed_in?
      
      FeedbackMailer.new_feedback_alert(suggestion).deliver
          
      respond_to do |format|
        format.js
      end
    else
      render :feedback
    end
  end
  
  def test_tweet
    social = PostFactory.new(current_user)
    social.post_to_twitter current_user.business.reviews.first

    Link.find_or_create_by_in_url(:in_url => social.short_link, :out_url => social.full_link)
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_li_update
    social = PostFactory.new(current_user)
    social.post_to_linkedin current_user.business.reviews.first

    Link.find_or_create_by_in_url(:in_url => social.short_link, :out_url => social.full_link)
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_fb_post
    social = PostFactory.new(current_user)
    social.post_to_facebook current_user.business.reviews.first

    Link.find_or_create_by_in_url(:in_url => social.short_link, :out_url => social.full_link)
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_fbfp_access
    @accounts = current_user.facebook.accounts
  end
end
