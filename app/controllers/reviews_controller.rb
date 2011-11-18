class ReviewsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :get_review, :only => [:destroy, :approve, :dispute, :reject]
  
  def index
    @business = Business.find(params[:business_id])
    
    @view = (params[:v] || 1).to_i
    
    case @view
      when 1   # Pending
        @reviews = @business.pending_reviews
        @header = "Reviews Pending Approval"
      when 2   # Approved
        @reviews = @business.approved_reviews
        @header = "Approved Reviews"
      when 3   # Rejected
        @reviews = @business.rejected_reviews
        @header = "Rejected Reviews"
    end
    
    @reviews = @reviews.order('created_at DESC').paginate(:page => params[:page])
  end
      
  def show
    @review = Review.find(params[:id])
  end
  
  def new
    if !params[:token].nil?
      token = params[:token]
      
      if !is_token_valid? token
        render :text => "<strong>This token is invalid. Please try reclicking the link included in the request email.</strong>", :layout => true
        return
      end
        
      if !is_review_submitted? token
        render :text => "<strong>A review has already been submitted for this request.</strong>", :layout => true
        return
      end
      
      @review = Business.find(params[:business_id]).reviews.build(:review_request_id => ReviewRequest.find_by_token(token).id)
    else
      @review = Business.find(params[:business_id]).reviews.build()
    end
    
    if params[:v] == 'popup'
      render :layout => false
    else
      render :layout => true 
    end
  end

  def create
    Business.find(params[:business_id]).reviews.create!(params[:review])
    
    respond_to do |format|
      format.html {
        redirect_to(@review.business)
      }
      format.js
    end
  end

  def destroy
    @review.destroy
    @review.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def approve
    @review.update_attributes(:is_approved => true)
    @review.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def reject
    @review.update_attributes(:is_rejected => true)
    @review.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def dispute
    @review.update_attributes(:is_under_review => true)
    @review.save
    
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def get_review
    @review = Review.find(params[:id])
  end
  
  def is_token_valid? token
    !ReviewRequest.find_by_token(token).nil?
  end
  
  def is_review_submitted? token
    request = ReviewRequest.find_by_token(token)
    
    Review.find_by_review_request_id(request.id).nil?   # Review not already submitted for request
  end
end
