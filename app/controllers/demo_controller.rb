class DemoController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :mock_objects
  
  def home
    render :layout => 'demo'
  end
  
  def social
    client = TwitterOAuth::Client.new(
        :consumer_key => TWITTER_CONSUMER_KEY,
        :consumer_secret => TWITTER_CONSUMER_SECRET
    )

    request_token = client.request_token(:oauth_callback => oauth_confirm_url)
    render :json => request_token.authorize_url
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
  
  private
  
  def mock_objects
    sign_in User.find(1)
    @business = current_user.businesses.first
    @reviews = @business.reviews.where(:is_approved => true).order('created_at DESC').limit(7)
  end
end
