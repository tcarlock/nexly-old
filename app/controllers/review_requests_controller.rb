class ReviewRequestsController < ApplicationController
  before_filter :get_business, :only => [:index, :new, :create]
 
  def new
  end

  def create    
    params[:emails].split(",").each do |email|
      review_request = @business.review_requests.create(
                 :email => email.strip,
                 :message => params[:message],
                 :business_id => params[:business_id],
                 :user_id => current_user.id)
                   
      ReviewMailer.new_request_alert(review_request).deliver if review_request.valid?
    end
    
    redirect_to(business_review_requests_path(@business), :notice => "Your requests have been sent")
  end
  
  def destroy
    review_request = ReviewRequest.find(params[:id]).destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  private 
  
  def get_business
    @business = Business.find(params[:business_id])
  end
end
