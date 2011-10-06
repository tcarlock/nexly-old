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
    
    if !current_user.businesses.first.nil?
      @business = current_user.businesses.first
      @reviews = @business.reviews.order('created_at DESC').paginate(:page => params[:page])
    end
  end
  
  def create_service_request
    @request = ServiceRequest.create(params[:service_request])
    
    ServiceRequestMailer.deliver_new_request_alert(@request)
    
    if @request.save
      respond_to do |format|
        format.html {
          redirect_to(:root, :notice => 'Thanks for contacting us. We''ll follow up with you shortly.')
        }
        format.js
      end
    else
      render :action => :welcome
    end
  end
  
  def contact
  end
end
