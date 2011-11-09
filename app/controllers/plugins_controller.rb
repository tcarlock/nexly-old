class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :init_objects, :only => [:toolbar, :toolbar_script]
  
  def toolbar
    render :layout => false
  end
  
  def toolbar_script
    render :content_type => 'text/javascript', :layout => false, :locals => { :network => params[:network] }
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
    @business = Business.find_by_api_token(params[:network])
    @reviews = @business.reviews.where(:is_approved => true).order('created_at DESC').limit(7)
  end
end
