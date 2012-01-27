class RecommendationsController < ApplicationController
  include LinkHelper

  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @view = params[:v] || 'standard'

    if Rails.env == 'production' && signed_in? && !current_user.business.nil?
      if current_user.business.id == @business.id
        if params[:v] == 'popup'
          layout = false
        else
          layout = true
        end
        
        render :text => "<strong>You cannot recommend your own business.</strong>", :layout => layout
        return
      end
    end

    @rec = Business.find(params[:business_id]).recommendations.build()
    
    if params[:v] == 'popup'
      render :layout => 'plugin_canvas'
    else
      render :layout => true 
    end
  end

  def create
    @business = Business.find(params[:business_id])
    @rec = @business.recommendations.create(params[:recommendation])
    
    if @rec.valid?
      @post = PlatformPost.new(@business, DOMAIN_NAMES[Rails.env], @rec)
      @post.generate_link(:email, nil)

      RecommendationMailer.new_recommendation_alert(@rec, @post.link).deliver
    
      render :nothing => true
    else
      render :new
    end
  end
end
