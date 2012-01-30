class RecommendationsController < ApplicationController
  include LinkHelper

  skip_before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :get_business

  def new
    @view = params[:v] || 'standard'

    if @view == 'toolbar'
      layout = 'plugin_canvas'
    else
      layout = true
    end

    if Rails.env == 'production' && signed_in? && !current_user.business.nil?
      if current_user.business.id == @business.id
        render :text => "<strong>You cannot recommend your own business.</strong>", :layout => layout
        return
      end
    end

    @rec = @business.recommendations.build()

    render :layout => layout
  end

  def create
    @rec = @business.recommendations.create(params[:recommendation])
    
    if @rec.valid?
      @post = PlatformPost.new(@business, DOMAIN_NAMES[Rails.env], @rec)
      @post.generate_link(:email, nil)

      # Shorten link and track
      @bitly_api_key = 'R_5ce84a66ab4a18fd093901d718c27545'
      @link_tracking_url = DOMAIN_NAMES[Rails.env] + '/analytics/track_link'

      TrackingLink.find_or_create_by_in_url(:in_url => shorten_link(@post.link), :out_url => @post.link, :business_id => params[:business_id])
      RecommendationMailer.new_recommendation_alert(@rec, @post.link).deliver
    
      render :nothing => true
    else
      render :new
    end
  end

  private

  def get_business
    if params[:business_id] != nil
      @business = Business.find(params[:business_id])
    end
  end
end
