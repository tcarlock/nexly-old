class SettingsController < ApplicationController
  before_filter :get_business
  
  def index
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
  
  def toggle_toolbar_activation
    update_setting :is_toolbar_active, !@business.preferences[:is_toolbar_active]    
    render :nothing => true
  end
  
  def toggle_public_reviews
    update_setting :is_reviewing_enabled, !@business.preferences[:is_reviewing_enabled]    
    render :nothing => true
  end
  
  def toggle_public_recommendations
    update_setting :is_recs_enabled, !@business.preferences[:is_recs_enabled]    
    render :nothing => true
  end
  
  private

  def get_business
    @business = current_user.business
  end
  
  def update_setting key, value
    @business.preferences[key] = value
    @business.save
  end
end
