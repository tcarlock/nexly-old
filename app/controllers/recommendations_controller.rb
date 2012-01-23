class RecommendationsController < ApplicationController
  include LinkHelper

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
      @post = PlatformPost.new(@current_user.business, root_domain, resource)
      @post.generate_link(:email, nil)

      RecommendationMailer.new_recommendation_alert(@rec, @post.link).deliver
    
      render :nothing => true
    else
      render :new
    end
  end
end
