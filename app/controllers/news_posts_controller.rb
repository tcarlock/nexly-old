class NewsPostsController < ApplicationController
  before_filter :get_business, :only => [:index, :new, :create]

  def index
    @posts = @business.news_posts
  end

  def show
    @post = NewsPosts.find(params[:id])
  end

  def new
    @post = @business.news_posts.build
  end

  def create
    @post = @business.news_posts.create(params[:news_post])

    PostFactory.new(current_user, DOMAIN_NAMES[Rails.env]).post_to_all @post

    if @post.valid?
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def destroy
    NewsPost.find(params[:id]).destroy
        
    respond_to do |format|
      format.js
    end
  end
    
  private

  def get_business
    if params[:business_id] != nil
      @business = Business.find(params[:business_id])
    end
  end
end
