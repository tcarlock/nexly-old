class RecommendationsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
    if Rails.env == "production" && signed_in?
      if current_user.business.id == @business.id
        render :text => "<strong>You cannot recommend your own business.</strong>", :layout => true
        return
      end
    end

    @rec = Business.find(params[:business_id]).recommendations.build()
    
    if params[:v] == "popup"
      render :layout => "plugin_canvas"
    else
      render :layout => true 
    end
  end

  def create
    @rec = Business.find(params[:business_id]).recommendations.create(params[:recommendation])
    
    if @rec.valid?
      RecommendationMailer.new_recommendation_alert(@rec).deliver
    
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
end
