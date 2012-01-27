class ReviewsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :get_business
  before_filter :get_review, :only => [:destroy, :approve, :dispute, :reject]

  def review_requests
    @view = 'requests'
    @requests = @business.review_requests.where(:is_reviewed => false).paginate(:page => params[:page])
    @header = 'Review Requests'

    render :template => 'reviews/index'
  end
      
  def pending_reviews
    get_reviews :pending
  end
      
  def approved_reviews
    get_reviews :approved
  end
      
  def rejected_reviews
    get_reviews :rejected
  end

  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @view = params[:v] || 'standard'

    if Rails.env == 'production' && signed_in? && !current_user.business.nil?
      if current_user.business.id == @business.id
        if params[:v] == 'popup'
          layout = false
        else
          layout = true
        end
        
        render :text => "<strong>You cannot review your own business.</strong>", :layout => layout
        return
      end
    end

    if params[:token].nil?   # No token supplied
      if !@business.preferences[:tb_show_review_btn]   # Business does not allow public reviews without token; don't allow
        if params[:v] == 'popup'
          layout = false
        else
          layout = true
        end
        
        render :text => "<strong>This business does not allow public reviews.</strong>", :layout => layout
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
      @review = @business.reviews.build(:review_request_id => 0)
    else
      @review = @business.reviews.build(:review_request_id => request.id)
    end

    if params[:v] == 'popup'
      render :layout => 'plugin_canvas'
    else
      render :layout => true 
    end
  end

  def create
    @review = @business.reviews.create(params[:review])
    
    if @review.valid?
      unless params[:review][:review_request_id].to_i == 0  
        ReviewRequest.find(params[:review][:review_request_id].to_i).update_attributes(:is_reviewed => true)
      end

      ReviewMailer.new_review_alert(@review, business_approved_reviews_path(@business)).deliver

      render :nothing => true
    else
      render :new
    end
  end
  
  def approve
    @review.update_attributes(:is_approved => true, :is_rejected => false)

    PostFactory.new(current_user, DOMAIN_NAMES[Rails.env], @review).post_to_all
    
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
  
  def get_reviews status
    case status
      when :pending
        @reviews = @business.pending_reviews
        @header = 'Reviews Pending Approval'
      when :approved
        @reviews = @business.approved_reviews
        @header = 'Approved Reviews'
      when :rejected
        @reviews = @business.rejected_reviews
        @header = 'Rejected Reviews'
    end

    @view = status.to_s
    @reviews = @reviews.order('created_at DESC').paginate(:page => params[:page])

    render 'reviews/index'
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
