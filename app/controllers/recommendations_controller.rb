class RecommendationsController < ApplicationController
  include LinkHelper

  skip_before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @view = params[:v] || 'standard'

    if Rails.env == 'production' && signed_in?
      if current_user.business.id == @business.id
        if params[:v] == 'popup'
          render :text => "<strong>You cannot recommend your own business.</strong>", :layout => false
        else
          render :text => "<strong>You cannot recommend your own business.</strong>", :layout => true
        end

        return
      end
    end

    @rec = Business.find(params[:business_id]).recommendations.build()
    
    if params[:v] == 'popup'
      render :layout => "plugin_canvas"
    else
      render :layout => true 
    end
  end

  def create
    @biz = Business.find(params[:business_id])
    @rec = @biz.recommendations.create(params[:recommendation])
    
    if @rec.valid?
      @post = PlatformPost.new(@biz, DOMAIN_NAMES[Rails.env], @rec)
      @post.generate_link(:email, nil)

      RecommendationMailer.new_recommendation_alert(@rec, @post.link).deliver
    
      render :nothing => true
    else
      render :new
    end
  end
end
