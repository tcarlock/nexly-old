class DemoController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :mock_objects
  
  
  def home
    render :layout => 'demo'
  end
  
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
  
  def mock_objects
    @business = Business.find(1)
    sign_in User.find(1)
  end
end
