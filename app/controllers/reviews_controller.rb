class ReviewsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :get_business, :only => [:index, :new, :create]
  before_filter :get_review, :only => [:destroy, :approve, :dispute, :reject]
  
  def index
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
    if Rails.env == "production" && signed_in?
      if current_user.business.id == @business.id
        render :text => "<strong>You cannot review your own business.</strong>", :layout => true
        return
      end
    end

    if params[:token].nil?   # No token supplied
      if !@business.preferences[:tb_show_review_btn]   # Business does not allow public reviews without token; don't allow
        render :text => "<strong>This business does not allow public reviews.</strong>", :layout => true
        return
      end
    else   # Token supplied; validate
      token = params[:token]
  
      request = ReviewRequest.find_by_token(token)

      if request.nil?   #Token invalid
        render :text => "<strong>This token is invalid. Please try reclicking the link included in the request email.</strong>", :layout => true
        return
      end
      
      unless Review.find_by_review_request_id(request.id).nil?   #Review already submitted for this token
        render :text => "<strong>A review has already been submitted for this request.</strong>", :layout => true
        return
      end
    end

    if request.nil?
      @review = @business.reviews.build()
    else
      @review = @business.reviews.build(:review_request_id => request.id)
    end
    
    if params[:v] == "popup"
      render :layout => false
    else
      render :layout => true 
    end
  end

  def create
    @review = @business.reviews.create(params[:review])
    
    if @review.valid?
      unless params[:review][:review_request_id].nil?  
        ReviewRequest.find(params[:review][:review_request_id].to_i).update_attributes(:is_reviewed => true)
      end

      ReviewMailer.new_review_alert(@review).deliver

      respond_to do |format|
        format.html {
          redirect_to(@review.business)
        }
        format.js
      end
    else
      render :new
    end
  end

  def destroy
    @review.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  def approve
    @review.update_attributes(:is_approved => true, :is_rejected => false)

    PostFactory.new(current_user, DOMAIN_NAMES[Rails.env]).post_to_all @review
    
    respond_to do |format|
      format.js
    end
  end
  
  def reject
    @review.update_attributes(:is_approved => false, :is_rejected => true)
    
    respond_to do |format|
      format.js
    end
  end
  
  def dispute
    @review.update_attributes(:is_under_review => true)
    
    respond_to do |format|
      format.js
    end
  end
  
  private

  def get_business
    if params[:business_id] != nil
      @business = Business.find(params[:business_id])
    end
  end
  
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
