class MainController < ApplicationController
  skip_before_filter :authenticate_user!, :except => :dashboard
  
  def welcome
    if signed_in?
      redirect_to dashboard_path
    end
  end
  
  def faqs
  end
  
  def dashboard
    @user = current_user
    @profile = current_user.profile
    @business = current_user.businesses.first
    @reviews = @business.reviews.order('created_at DESC').paginate(:page => params[:page])
  end
  
  def open_popup
    LinkClick.create!(:url => params[:url])
    
    redirect_to params[:url]
  end
end
