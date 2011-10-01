class ReviewRequestsController < ApplicationController
  def new
  end

  def create
    business = Business.find(params[:business_id])
    
    params[:emails].split(",").each do |email|
      review_request = business.review_requests.create!(
                 :email => email,
                 :message => params[:message],
                 :token => rand(36**8).to_s(36),
                 :business_id => params[:business_id],
                 :user_id => current_user.id)
        
      ReviewMailer.new_request_alert(review_request).deliver
    end
    
    redirect_to(business, :notice => "Your requests have been sent")
  end
end
