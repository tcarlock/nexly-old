class PluginsController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :check_for_biz
  before_filter :init_objects
  
  def toolbar
    is_rev_enabled = @business.preferences[:tb_show_review_btn]
    tb_show_rec_btn = @business.preferences[:tb_show_rec_btn]

    render :layout => false,
    :locals => { 
      :network => @network, 
      :root => @root, 
      :is_rev_enabled => is_rev_enabled,
      :tb_show_rec_btn => tb_show_rec_btn
    }
  end
  
  def plugin_render_script
    enable_toolbar = @business.preferences[:enable_toolbar]
    is_rev_enabled = @business.preferences[:tb_show_review_btn]
    tb_show_rec_btn = @business.preferences[:tb_show_rec_btn]
    
    render :content_type => 'text/javascript', 
      :layout => false, 
      :locals => { 
        :network => @network, 
        :root => @root, 
        :enable_toolbar => enable_toolbar,
        :is_rev_enabled => is_rev_enabled,
        :tb_show_rec_btn => tb_show_rec_btn
      }
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
