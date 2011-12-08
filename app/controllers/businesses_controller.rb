class BusinessesController < ApplicationController
  before_filter :get_business, :except => [:index, :create]
  before_filter :set_menu_visibility, :only => [:new, :create]
  skip_before_filter :check_for_biz, :only => [:new, :create]   # Filter in application_controller; skip to prevent infinite redirects
  
  def index
    @businesses = Business.search params[:q]
  end

  def show
    @reviews = @business.reviews.order('created_at DESC').paginate(:page => params[:page])
  end

  def new
    @business = current_user.businesses.build()
  end
  
  def edit
  end

  def create
    @business = current_user.businesses.create(params[:business])
    
    if @business.save
      redirect_to settings_path, :notice => 'Your business profile has been saved'
    else
      render :new
    end
  end
  
  def update
    if params[:business][:update_tags]
      tags = params[:business][:capabilities_string].split(",")   
      @business.capability_list = tags
    end

    if @business.update_attributes(params[:business])
      redirect_to @business, :notice => 'Your business profile has been updated'
    else
      render :edit
    end
  end
  
  private

  def get_business
    if params[:id] != nil
      @business = Business.find(params[:id])
    end
  end
end
