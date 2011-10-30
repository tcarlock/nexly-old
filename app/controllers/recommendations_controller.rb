class RecommendationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @rec = Business.find(params[:business_id]).recommendations.build()
    
    render :layout => false
  end

  def create
    @rec = Business.find(params[:business_id]).recommendations.create(params[:rec])
    
    RecommendationMailer.new_recommendation(@rec).deliver
    
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
end
