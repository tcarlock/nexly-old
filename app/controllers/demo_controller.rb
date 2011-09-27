class DemoController < ApplicationController
  before_filter :get_business
  
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
  
  def get_business
    @business = Business.find(1)
  end
end
