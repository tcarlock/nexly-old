class ReviewsController < ApplicationController
  before_filter :get_review, :only => [:destroy, :feature, :dispute]
  
  def index
    @business = Business.find(params[:business_id])
    @reviews = @business.reviews.order('created_at DESC').paginate(:page => params[:page])
  end
      
  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @review = Business.find(params[:business_id]).reviews.build()
  end

  def create
    @review = Business.find(params[:business_id]).reviews.create(params[:review])
    
    if @review.save
      redirect_to(@review.business)
    else
      render :action => new
    end
  end

  def destroy
    @review.destroy
    @review.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def feature
    @review.update_attributes(:is_featured => true)
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
