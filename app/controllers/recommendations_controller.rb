class RecommendationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @rec = Business.find(params[:business_id]).recommendations.build()
    
    if params[:v] == 'popup'
      render :layout => false
    else
      render :layout => true 
    end
  end

  def create
    @rec = Business.find(params[:business_id]).recommendations.create(params[:rec])
    
    if @rec.valid?
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
    else
      render :new
    end
  end
end
