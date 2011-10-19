class MainController < ApplicationController
  skip_before_filter :authenticate_user!, :except => :dashboard
  
  def welcome
    if signed_in?
      redirect_to dashboard_path
    else
      @signup = BetaSignup.new()
    end
  end
  
  def faqs
  end
  
  def dashboard
    @user = current_user
    @profile = current_user.profile
    @business = current_user.businesses.first
    # @reviews = @business.reviews.order('created_at DESC').paginate(:page => params[:page])
    @pending_reviews = @business.pending_reviews.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end
  
  def open_popup
    LinkClick.create!(:url => params[:url], 
        :referrer_domain => params[:url].split('/')[2],
        :business_id => params[:bId],
        :reference_id =>params[:rId],
        :link_type_id => params[:tId])
    
    redirect_to params[:url]
  end
  
  def test_tweet
    current_user.twitter.update("My Rails 3 App with Omniauth, Devise and Twitter")
    
    respond_to do |format|
      format.js
    end
  end
  
  def test_fb_post
    current_user.facebook.feed!(
      :message => 'Hello, Facebook!', 
      :name => 'My Rails 3 App with Omniauth, Devise and FB_graph'
    )
    
    respond_to do |format|
      format.js
    end
  end
end
