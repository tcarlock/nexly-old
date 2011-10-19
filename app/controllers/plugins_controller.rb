class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :init_objects
  
  def toolbar
    render :layout => false
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
    token = params[:token]
    # @business = Business.find_by_api_token(token)
    @business = Business.first
    @reviews = @business.reviews.where(:is_approved => true).order('created_at DESC').limit(7)
  end
end
