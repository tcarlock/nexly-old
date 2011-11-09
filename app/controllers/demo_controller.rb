class DemoController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :mock_objects
  
  def home
    render :layout => 'demo'
  end
  
  def social
    
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
  
  def mock_objects
    sign_in User.find(1)
    @business = current_user.business
    @reviews = @business.reviews.where(:is_approved => true).order('created_at DESC').limit(7)
    @root = DOMAIN_NAMES[Rails.env]
  end
end
