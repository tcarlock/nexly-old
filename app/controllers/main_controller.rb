class MainController < ApplicationController
  skip_before_filter :authenticate_user!, :except => [:dashboard, :init_settings, :settings]
  
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

  def settings
    @root = DOMAIN_NAMES[Rails.env]
    
    @display_pages = params[:display_pages].nil? ? false : true   # Controls whether popup is displayed for user to select fanpages

    @business = current_user.business
    
    @nexly_apps = Application.where(:is_public => true)
    @enabled_apps = @business.applications

    @platforms = Platform.where(:is_available => true).order(:display_order)
    @enabled_platforms = current_user.authentications
    @platform_suggestion = PlatformSuggestion.new
    
    @plugin_bootstrap_script = render_to_string :partial => 'plugins/plugin_bootstrap_script', :locals => { :network => @business.api_token, :root => @root }
    @plugin_init_script = render_to_string :partial => 'plugins/plugin_init_script'
    
    # For each app, get details and html to render text area with code for embedding
    @content_pages_html = @nexly_apps.inject([]) do |result, element|
      result << {
        :app_id => element.id,
        :app_title => element.title, 
        :placeholder_html => render_to_string(:partial => 'plugins/content_page_placeholder', :locals => { :network => @business.api_token, :root => @root, :app_id => element.id })}
    end
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
end
