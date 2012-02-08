class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :check_for_biz
  before_filter :init_objects
   
  def plugin_render_script
    @enable_toolbar = @business.preferences[:enable_toolbar]
    @tb_show_review_btn = @business.preferences[:tb_show_review_btn]
    @tb_show_rec_btn = @business.preferences[:tb_show_rec_btn]
    @tb_bg_color = @business.preferences[:tb_bg_color]
    @tb_font_color = @business.preferences[:tb_font_color]
    @canvas_bg_color = @business.preferences[:canvas_bg_color]
    
    render :content_type => 'text/javascript', :layout => false
  end
  
  def content_page_placeholder
    render :layout => false 
  end
  
  def render_content_page
    app_id = params[:app].to_i
    app = Feature.find(app_id)
    
    case app_id
      when 1   # Display reviews
        partial = "plugins/reviews_page"
    end
    
    render :partial => partial,  :layout => false
  end

  def reviews
    render "plugins/reviews_canvas", :locals => { :truncate_review => false }, :layout => "plugin_canvas"
  end
  
  protected
  
  def init_objects
    @root = DOMAIN_NAMES[Rails.env]
    @network = params[:network]
    @business = Business.find_by_api_token(@network)
    @enable_reviews = true   # !@business.active_features.where(:lookup_key => "reviews").empty?
    @enable_news = false   # !@business.active_features.where(:lookup_key => "news").empty?
    @reviews = @business.reviews.where(:is_approved => true).order('created_at DESC')
    @news_posts = @business.news_posts.order('created_at DESC')
  end
end
