class MainController < ApplicationController
  def welcome
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
  
  def home
    if user_signed_in?
      if current_user.profile.created_at == current_user.profile.updated_at
        redirect_to edit_user_profile_path(current_user.profile)
      end
    end
  end
end
