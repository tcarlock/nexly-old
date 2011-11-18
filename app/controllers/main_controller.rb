class MainController < ApplicationController
  skip_before_filter :authenticate_user!, :except => [:dashboard, :init_settings, :settings]
  before_filter :get_settings, :only => [:init_settings, :settings]
  
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
    @business = current_user.business
    @platforms = Platform.where(:is_available => true)
    @pending_reviews = @business.pending_reviews.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)    
    @traffic = @business.traffic_browser([@business.created_at, 12.months.ago].max.beginning_of_month, DateTime.current.beginning_of_month)
  end
  
  def init_settings
  end
      
  def settings
    @business = current_user.business
    @apps = Application.where(:is_public => true)
    @enabled_apps = @business.applications
  end
  
  def redir
    PageView.create!(:url => params[:url],
        :business_id => params[:bId],
        :reference_id =>params[:rId],
        :link_type_id => params[:tId],
        :platform_id => params[:pId])
    
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
  
  def feedback
    render :layout => false
  end 
  
  def submit_feedback
    suggestion = Suggestion.create!(params[:suggestion])
    
    suggestion.update_attributes!(:user_id => current_user.id) if user_signed_in?
    
    FeedbackMailer.new_feedback_alert(suggestion).deliver
          
    respond_to do |format|
      format.js
    end
  end
  
  def test_tweet
    social = PostFactory.new(current_user)
    social.post_to_twitter! current_user.business.reviews.first

    Link.find_or_create_by_in_url(:in_url => social.short_link, :out_url => social.full_link)
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_li_update
    social = PostFactory.new(current_user)
    social.post_to_linkedin! current_user.business.reviews.first

    Link.find_or_create_by_in_url(:in_url => social.short_link, :out_url => social.full_link)
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_fb_post
    social = PostFactory.new(current_user)
    social.post_to_facebook! current_user.business.reviews.first

    Link.find_or_create_by_in_url(:in_url => social.short_link, :out_url => social.full_link)
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_fbfp_access
    @accounts = current_user.facebook.accounts
  end
  
  private
  
  def get_settings
    @platforms = Platform.where(:is_available => true).order(:display_order)
    @enabled_platforms = current_user.authentications
    @toolbar_bootstrap_script = render_to_string :partial => 'plugins/toolbar_bootstrap_script', :locals => { :network => current_user.business.api_token, :root => DOMAIN_NAMES[Rails.env] }
    @toolbar_init_script = render_to_string :partial => 'plugins/toolbar_init_script'
    @platform_suggestion = PlatformSuggestion.new
  end
end
