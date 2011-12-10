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

    factory = PostFactory.new(current_user).post_to_all @post


    if @post.valid?
      redirect_to business_news_posts_path(@business)
    else
      render :new
    end
  end

  def destroy
    NewsPosts.find(params[:id]).destroy
        
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
