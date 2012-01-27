class ReviewRequestsController < ApplicationController
  before_filter :get_business, :only => [:index, :new, :create]
  
  def index
    @requests = @business.review_requests.where(:is_reviewed => false).paginate(:page => params[:page])
  end
  
  def new
  end

  def create
    business = Business.find(params[:business_id])
    
    params[:emails].split(",").each do |email|
      review_request = business.review_requests.create(
                 :email => email.strip,
                 :message => params[:message],
                 :business_id => params[:business_id],
                 :user_id => current_user.id)
      
      redir_url = business.website + '?nexlyCanvasRef=new-review'
      ReviewMailer.new_request_alert(review_request, redir_url).deliver if review_request.valid?
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
