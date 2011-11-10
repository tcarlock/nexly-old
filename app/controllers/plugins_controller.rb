class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :init_objects, :only => [:toolbar, :toolbar_render_script]
  
  def toolbar
    render :layout => false
  end
  
  def toolbar_render_script
    render :content_type => 'text/javascript', :layout => false, :locals => { :network => @network, :root => @root,  }
  end
  
  def resources
    render :layout => 'demo'
  end
  
  def events
    render :layout => 'demo'
  end
  
  def contact
    render :layout => 'demo'
  end
  
  def reviews
    render :layout => 'demo'
  end
  
  protected
  
  def init_objects
    @network = params[:network]
    @business = Business.find_by_api_token(@network)
    @reviews = @business.reviews.where(:is_approved => true).order('created_at DESC').limit(7)
    @root = DOMAIN_NAMES[Rails.env]
  end
end
