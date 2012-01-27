class MainController < ApplicationController
  caches_page :welcome

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
    # @platforms = Platform.where(:is_available => true)
    
    # View settings
    # @business.active_features
    @active_feature_count = 1   # @business.active_features.count
    @enable_reviews = true   # !@business.active_features.where(:lookup_key => "reviews").empty?
    @enable_news = false   # !@business.active_features.where(:lookup_key => "news").empty?
    
    # Get datasets for dashboard charts
    @traffic_meta = @business.traffic_meta([@business.created_at, 12.months.ago].max.beginning_of_month, DateTime.current)
    
    @page_view_count = @traffic_meta.total_page_view_count

    @platform_allocation = @traffic_meta.get_traffic_allocation(TrafficMeta.filter_types[:platform]).to_json
    @channel_allocation = @traffic_meta.get_traffic_allocation(TrafficMeta.filter_types[:channel]).to_json
    
    @total_page_view_time_series = @traffic_meta.get_time_series(TrafficMeta.time_series[:monthly])
    @total_page_view_growth = @traffic_meta.get_percentage_change(TrafficMeta.time_series[:monthly])

    review_series = @traffic_meta.filter(TrafficMeta.filter_types[:resource_type], PlatformPost.resource_types[:review])
    @review_page_view_time_series = @traffic_meta.filter(TrafficMeta.filter_types[:resource_type], PlatformPost.resource_types[:review]).get_time_series(TrafficMeta.time_series[:monthly])
    @recommendation_page_view_time_series = @traffic_meta.filter(TrafficMeta.filter_types[:resource_type], PlatformPost.resource_types[:recommendation]).get_time_series(TrafficMeta.time_series[:monthly])

    @rating_dist = @business.review_meta.get_rating_distribution(false)

    # Get pending reviews
    @pending_reviews = @business.pending_reviews.order('created_at DESC').paginate(:page => params[:reviews_pg], :per_page => 7)
    # @news_posts = @business.news_posts.order('created_at DESC').paginate(:page => params[:news_pg])

    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def redir
    PageView.create(:url => params[:url],
        :business_id => params[:bizId],
        :channel_type_id => params[:channel],
        :resource_type_id => params[:resourceType],
        :resource_id =>params[:resourceId],
        :platform_id => (params[:platformId] || 0),
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
end
