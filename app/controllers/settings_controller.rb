class SettingsController < ApplicationController
  before_filter :get_business
  
  def features
    @features = Feature.where(:is_public => true)
    @active_feature_ids = @business.active_features.map { |f| f.id }
  end

  def toggle_feature
    subscrip = current_user.business.feature_subscriptions.find_or_initialize_by_feature_id(params[:id])

    if subscrip.persisted?   # Record already existed; delete
      subscrip.destroy
    else
      subscrip.save
    end

    @feature = subscrip.feature
    @active_feature_ids = @business.active_features.map { |f| f.id }

    respond_to do |format|
      format.js
    end
  end
  
  def platforms
    @root = DOMAIN_NAMES[Rails.env]
    @features = Feature.where(:is_public => true)
    @platforms = Platform.where(:is_available => true).order(:display_order)
    active_platforms = @business.active_platforms
    @active_platform_ids = active_platforms.map { |p| p.id }

    unless active_platforms.empty?
      fb_platform_id = Platform.find_by_name("facebook").id
      fb_platform = active_platforms.where(:id => fb_platform_id).first

      unless fb_platform.nil? || fb_platform.platform_pages.count > 0
        @display_fb_pages = true    # Controls whether popup is displayed for user to select fanpages
      end
    else
      @display_fb_pages = false
    end

    @platform_suggestion = PlatformSuggestion.new
    
    @plugin_bootstrap_script = render_to_string :partial => 'plugins/plugin_bootstrap_script', :locals => { :network => @business.api_token, :root => @root }
    @plugin_init_script = render_to_string :partial => 'plugins/plugin_init_script'
    
    # For each app, get details and html to render text area with code for embedding
    @content_pages_html = @features.inject([]) do |result, element|
      result << {
        :app_id => element.id,
        :app_title => element.title, 
        :placeholder_html => render_to_string(:partial => 'plugins/content_page_placeholder', :locals => { :network => @business.api_token, :root => @root, :app_id => element.id })}
    end
  end
  
  def toggle_toolbar_activation
    update_setting :enable_toolbar 
    render :nothing => true
  end
  
  def toggle_public_reviews
    update_setting :tb_show_review_btn
    render :nothing => true
  end
  
  def toggle_public_recommendations
    update_setting :tb_show_rec_btn
    render :nothing => true
  end
  
  private

  def get_business
    @business = current_user.business
  end
  
  def update_setting key
    @business.preferences[key] = !@business.preferences[key]
      
    @business.save
  end
end
