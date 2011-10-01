class MainController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def welcome
  end
  
  def faqs
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
