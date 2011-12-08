class SettingsController < ApplicationController
  before_filter :get_business
  
  def index
    @root = DOMAIN_NAMES[Rails.env]
    @business = current_user.business
    
    @nexly_apps = Application.where(:is_public => true)
    @enabled_apps = @business.applications

    @platforms = Platform.where(:is_available => true).order(:display_order)
    @enabled_platforms = @business.active_platforms

    fb_platform_id = Platform.find_by_name("facebook").id
    fb_platform = @enabled_platforms.find(fb_platform_id)

    if !@enabled_platforms.empty? && !fb_platform.nil? && fb_platform.platform_pages.count == 0
      @display_fb_pages = true   # Controls whether popup is displayed for user to select fanpages
    else
      @display_fb_pages = false
    end

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
