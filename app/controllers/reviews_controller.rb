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
    @review = Business.find(params[:business_id]).reviews.build()
    
    render :layout => false
  end

  def create
    @review = Business.find(params[:business_id]).reviews.create(params[:review])
    
    respond_to do |format|
      format.html {
        if @review.save
          redirect_to(@review.business)
        else
          render :action => new
        end
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
end
