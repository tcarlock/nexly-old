class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :init_objects
  
  def toolbar
    is_rev_enabled = @business.preferences[:is_reviewing_enabled]
    is_rec_enabled = @business.preferences[:is_rec_enabled]

    render :layout => false,
    :locals => { 
      :network => @network, 
      :root => @root, 
      :is_rev_enabled => is_rev_enabled,
      :is_rec_enabled => is_rec_enabled
    }
  end
  
  def plugin_render_script
    is_toolbar_enabled = @business.preferences[:is_toolbar_enabled]
    is_rev_enabled = @business.preferences[:is_reviewing_enabled]
    is_rec_enabled = @business.preferences[:is_rec_enabled]
    
    render :content_type => 'text/javascript', 
      :layout => false, 
      :locals => { 
        :network => @network, 
        :root => @root, 
        :is_toolbar_enabled => is_toolbar_enabled,
        :is_rev_enabled => is_rev_enabled,
        :is_rec_enabled => is_rec_enabled
      }
  end
  
  def content_page_placeholder
    render :layout => false 
  end
  
  def render_content_page
    app_id = params[:app].to_i
    app = Application.find(app_id)
    
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
