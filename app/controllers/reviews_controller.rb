class ReviewsController < ApplicationController
  def show
    @reviews = Business.find(params[:business_id]).reviews
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
  end
end
