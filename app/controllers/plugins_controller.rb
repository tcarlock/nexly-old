class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :init_objects
  
  def toolbar
    render :layout => false
  end
  
  def plugin_render_script
    render :content_type => 'text/javascript', :layout => false, :locals => { :network => @network, :root => @root  }
  end
  
  def content_page_placeholder
    render :layout => false 
  end
  
  def render_content_page
    app_id = params[:id].to_i
    app = Applications.find(app_id)
    
    case app_id
      when 1   # Display reviews
        partial = "plugins/reviews_page"
    end
    
    render :partial => partial,  :layout => false
  end
  
  protected
  
  def init_objects
    @root = DOMAIN_NAMES[Rails.env]
    @network = params[:network]
    @business = Business.find_by_api_token(@network)
    @reviews = @business.reviews.where(:is_approved => true).order('created_at DESC').limit(7)
  end
end
